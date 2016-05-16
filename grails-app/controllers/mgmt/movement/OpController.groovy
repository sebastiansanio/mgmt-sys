package mgmt.movement



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OpController {
	

    static allowedMethods = [save: "POST", check: "POST", uncheck: "POST", update: "PUT", delete: "DELETE"]

	def index(Integer max) {
		params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'dateCreated'
		params.order = params.order ?: 'desc'
		params.checkedFilter = params.checkedFilter ?: 'all'
		
		def results = Movement.createCriteria().list (params) {
			if(! (params.checkedFilter == "all")){
				eq("checked",params.checkedFilter == "checked")
			}
			eq("type", "op")
			if(params.numberFilter){
				eq("number", params.numberFilter.toLong())
			}
			if(params.yearFilter){
				eq("year", params.yearFilter.toInteger())
			}
			order(params.sort, params.order)
		}
		
		respond results, model:[movementInstanceCount: results.totalCount]
	}

    def show(Movement movementInstance) {
		if (movementInstance == null || movementInstance.type != 'op') {
			notFound()
			return
		}
		respond movementInstance
    }

    def create() {
        respond new Movement(params)
    }

    @Transactional
    def save(Movement movementInstance) {
        if (movementInstance == null || movementInstance.type != 'op') {
            notFound()
            return
        }
		movementInstance.items = movementInstance.items - [null]
		movementInstance.payments = movementInstance.payments - [null]
		for(item in movementInstance.items){
			item.multiplier = -1
		}
		for(payment in movementInstance.payments){
			payment.multiplier = -1
		}
		movementInstance.validate()
		
        if (movementInstance.hasErrors()) {
            respond movementInstance.errors, view:'create'
            return
        }																									

        movementInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [movementInstance.toString().toUpperCase(), movementInstance.id])
                redirect action:"index", method:"GET", fragment: 'movement-'+movementInstance.id, params:params.subMap(['max','sort','order','offset','checkedFilter','numberFilter','yearFilter'])
            }
            '*' { respond movementInstance, [status: CREATED] }
        }
    }

    def edit(Movement movementInstance) {
		if (movementInstance == null || movementInstance.type != 'op') {
			notFound()
			return
		}
        respond movementInstance
    }

    @Transactional
    def update() {
		
		def movementInstance = Movement.get(params.id.toLong())
        if (movementInstance == null || movementInstance.type != 'op') {
            notFound()
            return
        }
		if (params.version) {
			def version = params.version.toLong()
			if (movementInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: movementInstance.id
				return
			}
		}
		if(movementInstance.checked){
			flash.error = message(code: 'movement.isChecked.error')
			redirect action:"index", method:"GET"
			return
		}
				
		for (movementItem in movementInstance.items) {
			movementItem.delete()
		}
		movementInstance.items.clear()
		for (payment in movementInstance.payments) {
			payment.delete()
		}
		movementInstance.payments.clear()
		
		movementInstance.properties = params
		movementInstance.items = movementInstance.items - [null]
		movementInstance.payments = movementInstance.payments - [null]
		for(item in movementInstance.items){
			item.multiplier = -1
		}
		for(payment in movementInstance.payments){
			payment.multiplier = -1
		}
		movementInstance.validate()
		if (movementInstance.hasErrors()) {
            respond movementInstance.errors, view:'edit'
            return
        }
		
        movementInstance.save flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [movementInstance.toString().toUpperCase(), movementInstance.id])
                redirect action:"index", method:"GET", fragment: 'movement-'+movementInstance.id , params:params.subMap(['max','sort','order','offset','checkedFilter','numberFilter','yearFilter'])
            }
            '*'{ respond movementInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Movement movementInstance) {
        if (movementInstance == null || movementInstance.type != 'op') {
            notFound()
            return
        }
		if(movementInstance.checked){
			flash.error = message(code: 'movement.isChecked.error')
			redirect action:"index", method:"GET"
			return
		}
        movementInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [movementInstance.toString().toUpperCase(), movementInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	@Transactional
	def check(){
		def movementInstance = Movement.get(params.id.toLong())
		if (movementInstance == null || movementInstance.type != 'op') {
			notFound()
			return
		}
		for(item in movementInstance.items){
			if (!(item.date >= mgmt.config.Parameter.findByCode("FECHA_DESDE").asDate() && item.date <= mgmt.config.Parameter.findByCode("FECHA_HASTA").asDate())){
				flash.error = message(code: "movementItem.dateOutOfRange.message")
				redirect action:"index", method:"GET",fragment: 'movement-'+movementInstance.id, params:params
				return
			}
		}
		for(payment in movementInstance.payments){
			if (!(payment.paymentDate >= mgmt.config.Parameter.findByCode("FECHA_PAGO_DESDE").asDate() && payment.paymentDate <= mgmt.config.Parameter.findByCode("FECHA_PAGO_HASTA").asDate())){
				flash.error = message(code: "payment.dateOutOfRange.message")
				redirect action:"index", method:"GET",fragment: 'movement-'+movementInstance.id, params:params
				return
			}
		}
		
		movementInstance.checked = true
		movementInstance.save flush: true
		flash.message = message(code: 'movement.checked.message')
		redirect action:"index", method:"GET",fragment: 'movement-'+movementInstance.id, params:params
		
	}
	@Transactional
	def uncheck(){
		def movementInstance = Movement.get(params.id.toLong())
		if (movementInstance == null || movementInstance.type != 'op') {
			notFound()
			return
		}
		for(item in movementInstance.items){
			if (!(item.date >= mgmt.config.Parameter.findByCode("FECHA_DESDE").asDate() && item.date <= mgmt.config.Parameter.findByCode("FECHA_HASTA").asDate())){
				flash.error = message(code: "movementItem.dateOutOfRange.message")
				redirect action:"index", method:"GET",fragment: 'movement-'+movementInstance.id, params:params
				return
			}
		}
		for(payment in movementInstance.payments){
			if (!(payment.paymentDate >= mgmt.config.Parameter.findByCode("FECHA_PAGO_DESDE").asDate() && payment.paymentDate <= mgmt.config.Parameter.findByCode("FECHA_PAGO_HASTA").asDate())){
				flash.error = message(code: "payment.dateOutOfRange.message")
				redirect action:"index", method:"GET",fragment: 'movement-'+movementInstance.id, params:params
				return
			}
		}
		movementInstance.checked = false
		movementInstance.save flush: true
		flash.message = message(code: 'movement.unchecked.message')
		redirect action:"index", method:"GET",fragment: 'movement-'+movementInstance.id, params:params
	}

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'movement.label', default: 'Movement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
