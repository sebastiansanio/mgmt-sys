package mgmt.movement



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TrController {
	

    static allowedMethods = [save: "POST", check: "POST", uncheck: "POST", update: "PUT", delete: "DELETE"]

     def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'dateCreated'
		params.order = params.order ?: 'desc'
        respond Movement.findAllByType('tr',params), model:[movementInstanceCount: Movement.countByType('tr')]
    }
	 
	def search(Integer max) {
		params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'id'
		params.order = params.order ?: 'desc'
		
		def results = Movement.createCriteria().list (params) {
			if(! (params.checked == "all")){
				eq("checked",params.checked == "checked")
			}
			eq("type", "tr")
			if(params.number){
				eq("number", params.number.toLong())
			}
			if(params.year){
				eq("year", params.year.toInteger())
			}
			order(params.sort, params.order)
		}
		
		respond results, model:[movementInstanceCount: results.totalCount],  view:'index'
	}
	 
    def show(Movement movementInstance) {
		if (movementInstance == null || movementInstance.type != 'tr') {
			notFound()
			return
		}
		respond movementInstance
    }

    def create() {
        respond new Movement(params)
    }
	
	private void fillPayments(Movement movement){
		movement.payments[1].amount = movement.payments[0].amount
		movement.payments[1].paymentDate = movement.payments[0].paymentDate
		movement.payments[1].note = movement.payments[0].note
		movement.payments[0].multiplier = -1 
		movement.payments[1].multiplier = 1
	}

    @Transactional
    def save(Movement movementInstance) {
        if (movementInstance == null || movementInstance.type != 'tr') {
            notFound()
            return
        }
		fillPayments(movementInstance)
		
		movementInstance.validate()
        if (movementInstance.hasErrors()) {
            respond movementInstance.errors, view:'create'
            return
        }																						

        movementInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [movementInstance.toString().toUpperCase(), movementInstance.id])
                redirect action:"index", method:"GET"
            }
            '*' { respond movementInstance, [status: CREATED] }
        }
    }

    def edit(Movement movementInstance) {
		if (movementInstance == null || movementInstance.type != 'tr') {
			notFound()
			return
		}
        respond movementInstance
    }

    @Transactional
    def update() {
		
		def movementInstance = Movement.get(params.id.toLong())
        if (movementInstance == null || movementInstance.type != 'tr') {
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
		movementInstance.properties = params
		fillPayments(movementInstance)
		movementInstance.validate()
		if (movementInstance.hasErrors()) {
            respond movementInstance.errors, view:'edit'
            return
        }
        movementInstance.save flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [movementInstance.toString().toUpperCase(), movementInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ respond movementInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Movement movementInstance) {
        if (movementInstance == null || movementInstance.type != 'tr') {
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
		if (movementInstance == null || movementInstance.type != 'tr') {
			notFound()
			return
		}
		movementInstance.checked = true
		movementInstance.save flush: true
		flash.message = message(code: 'movement.checked.message')
		redirect action:"index", method:"GET"
		
	}
	@Transactional
	def uncheck(){
		def movementInstance = Movement.get(params.id.toLong())
		if (movementInstance == null || movementInstance.type != 'tr') {
			notFound()
			return
		}
		movementInstance.checked = false
		movementInstance.save flush: true
		flash.message = message(code: 'movement.unchecked.message')
		redirect action:"index", method:"GET"
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
