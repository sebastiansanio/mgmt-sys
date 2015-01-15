package mgmt.movement



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MovementController {
	

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Movement.list(params), model:[movementInstanceCount: Movement.count()]
    }

    def show(Movement movementInstance) {
        respond movementInstance
    }

    def create() {
        respond new Movement(params)
    }

    @Transactional
    def save(Movement movementInstance) {
        if (movementInstance == null) {
            notFound()
            return
        }
		movementInstance.items?.removeAll{ it.deleted }
		movementInstance.payments?.removeAll{ it.deleted }
        if (movementInstance.hasErrors()) {
            respond movementInstance.errors, view:'create'
            return
        }

        movementInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'movement.label', default: 'Movement'), movementInstance.id])
                redirect movementInstance
            }
            '*' { respond movementInstance, [status: CREATED] }
        }
    }

    def edit(Movement movementInstance) {
        respond movementInstance
    }

    @Transactional
    def update(Movement movementInstance) {
        if (movementInstance == null) {
            notFound()
            return
        }
		movementInstance.items?.removeAll{ it.deleted }
		movementInstance.payments?.removeAll{ it.deleted }

        if (movementInstance.hasErrors()) {
            respond movementInstance.errors, view:'edit'
            return
        }

        movementInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Movement.label', default: 'Movement'), movementInstance.id])
                redirect movementInstance
            }
            '*'{ respond movementInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Movement movementInstance) {

        if (movementInstance == null) {
            notFound()
            return
        }

        movementInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Movement.label', default: 'Movement'), movementInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
