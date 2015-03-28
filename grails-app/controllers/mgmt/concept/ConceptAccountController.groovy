package mgmt.concept



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ConceptAccountController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 50, 1000)
        respond ConceptAccount.list(params), model:[conceptAccountInstanceCount: ConceptAccount.count()]
    }

    def show(ConceptAccount conceptAccountInstance) {
        respond conceptAccountInstance
    }

    def create() {
        respond new ConceptAccount(params)
    }

    @Transactional
    def save(ConceptAccount conceptAccountInstance) {
        if (conceptAccountInstance == null) {
            notFound()
            return
        }

        if (conceptAccountInstance.hasErrors()) {
            respond conceptAccountInstance.errors, view:'create'
            return
        }

        conceptAccountInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'conceptAccount.label', default: 'ConceptAccount'), conceptAccountInstance.id])
                redirect conceptAccountInstance
            }
            '*' { respond conceptAccountInstance, [status: CREATED] }
        }
    }

    def edit(ConceptAccount conceptAccountInstance) {
        respond conceptAccountInstance
    }

    @Transactional
    def update(ConceptAccount conceptAccountInstance) {
        if (conceptAccountInstance == null) {
            notFound()
            return
        }

        if (conceptAccountInstance.hasErrors()) {
            respond conceptAccountInstance.errors, view:'edit'
            return
        }

        conceptAccountInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ConceptAccount.label', default: 'ConceptAccount'), conceptAccountInstance.id])
                redirect conceptAccountInstance
            }
            '*'{ respond conceptAccountInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ConceptAccount conceptAccountInstance) {

        if (conceptAccountInstance == null) {
            notFound()
            return
        }

        conceptAccountInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ConceptAccount.label', default: 'ConceptAccount'), conceptAccountInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'conceptAccount.label', default: 'ConceptAccount'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
