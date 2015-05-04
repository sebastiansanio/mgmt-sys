package mgmt.movement



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FiController {
	

    static allowedMethods = [save: "POST", check: "POST", uncheck: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 50, 1000)
		params.sort = params.sort ?: 'id'
		params.order = params.order ?: 'desc'
        respond Movement.findAllByType('fi',params), model:[movementInstanceCount: Movement.countByType('fi')]
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
                flash.message = message(code: 'default.created.message', args: [message(code: 'movement.label', default: 'Movement'), movementInstance.id])
                redirect action: 'show', id: movementInstance.id
            }
            '*' { respond movementInstance, [status: CREATED] }
        }
    }

    def edit(Movement movementInstance) {
		if (movementInstance == null || movementInstance.type != 'fi') {
			notFound()
			return
		}
		if(movementInstance.checked){
			flash.error = message(code: 'movement.isChecked.error')
			redirect action: 'show', id: movementInstance.id
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
		if(movementInstance.checked){
			flash.message = message(code: 'movement.isChecked.error')
			redirect movementInstance
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
                flash.message = message(code: 'default.updated.message', args: [message(code: 'movement.label', default: 'Movement'), movementInstance.id])
                redirect action: 'show', id: movementInstance.id
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

        movementInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'movement.label', default: 'Movement'), movementInstance.id])
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
		redirect action: 'show', id: movementInstance.id
		
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
		redirect action: 'show', id: movementInstance.id
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