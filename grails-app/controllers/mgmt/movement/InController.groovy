package mgmt.movement



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InController {
	

    static allowedMethods = [save: "POST", check: "POST", uncheck: "POST", update: "PUT", delete: "DELETE"]

     def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'dateCreated'
		params.order = params.order ?: 'desc'
        respond Movement.findAllByType('in',params), model:[movementInstanceCount: Movement.countByType('in')]
    }
	 
	def search(Integer max) {
		 if(params.checked == "all"){
			 redirect action: 'index'
		 }
		 params.max = Math.min(max ?: 100, 1000)
		 params.sort = params.sort ?: 'id'
		 params.order = params.order ?: 'desc'
		 boolean checked = (params.checked == "checked")
		 respond Movement.findAllByCheckedAndType(checked,'in',params), model:[movementInstanceCount: Movement.countByCheckedAndType(checked,'in')],  view:'index'
	}

    def show(Movement movementInstance) {
		if (movementInstance == null || movementInstance.type != 'in') {
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
        if (movementInstance == null || movementInstance.type != 'in') {
            notFound()
            return
        }
		movementInstance.items = movementInstance.items - [null]
		movementInstance.payments = movementInstance.payments - [null]
		for(item in movementInstance.items){
			item.multiplier = 1
		}
		for(payment in movementInstance.payments){
			payment.multiplier = 1
		}
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
		if (movementInstance == null || movementInstance.type != 'in') {
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
        if (movementInstance == null || movementInstance.type != 'in') {
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
		for(item in movementInstance.items){
			item.multiplier = 1
		}
		for(payment in movementInstance.payments){
			payment.multiplier = 1
		}
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
        if (movementInstance == null || movementInstance.type != 'in') {
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
		if (movementInstance == null || movementInstance.type != 'in') {
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
		if (movementInstance == null || movementInstance.type != 'in') {
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
