package mgmt.movement



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FiController {
	

    static allowedMethods = [save: "POST", check: "POST", uncheck: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'dateCreated'
		params.order = params.order ?: 'desc'
        respond Movement.findAllByType('fi',params), model:[movementInstanceCount: Movement.countByType('fi')]
    }
	
	def search(Integer max) {
		params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'id'
		params.order = params.order ?: 'desc'
		
		def results = Movement.createCriteria().list (params) {
			if(! (params.checked == "all")){
				eq("checked",params.checked == "checked")
			}
			eq("type", "fi")
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
		if (movementInstance == null || movementInstance.type != 'fi') {
			notFound()
			return
		}
		respond movementInstance
    }

    def create() {
        respond new Movement(params)
    }

	private void fillItems(Movement movement){
		Date date = new Date().clearTime()
		for(int i = 0; i < movement.items.size()/2; i++){
			movement.items[2*i+1].description = movement.items[2*i].description
			movement.items[2*i+1].unit = movement.items[2*i].unit
			movement.items[2*i+1].quantity = movement.items[2*i].quantity
			movement.items[2*i+1].unitPrice = movement.items[2*i].unitPrice
			movement.items[2*i+1].amount = movement.items[2*i].amount
			movement.items[2*i+1].concept = movement.items[2*i].concept
			movement.items[2*i].total = movement.items[2*i].amount
			movement.items[2*i+1].total = movement.items[2*i+1].amount
			movement.items[2*i].multiplier = 1
			movement.items[2*i+1].multiplier = -1
			movement.items[2*i].date = date
			movement.items[2*i+1].date = date
		}
	}
	
    @Transactional
    def save() {
		Movement movementInstance = new Movement(params)
        if (movementInstance == null || movementInstance.type != 'fi') {
            notFound()
            return
        }
		movementInstance.items = movementInstance.items - [null]
		movementInstance.payments = movementInstance.payments - [null]
		fillItems(movementInstance)
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
		if (movementInstance == null || movementInstance.type != 'fi') {
			notFound()
			return
		}
        respond movementInstance
    }

    @Transactional
    def update() {
		
		def movementInstance = Movement.get(params.id.toLong())
        if (movementInstance == null || movementInstance.type != 'fi') {
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
		fillItems(movementInstance)
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
        if (movementInstance == null || movementInstance.type != 'fi') {
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
		if (movementInstance == null || movementInstance.type != 'fi') {
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
		if (movementInstance == null || movementInstance.type != 'fi') {
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
