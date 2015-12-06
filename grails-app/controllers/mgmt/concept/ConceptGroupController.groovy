package mgmt.concept



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ConceptGroupController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond ConceptGroup.list(params), model:[conceptGroupInstanceCount: ConceptGroup.count()]
    }

    def show(ConceptGroup conceptGroupInstance) {
        respond conceptGroupInstance
    }

    def create() {
        respond new ConceptGroup(params)
    }

    @Transactional
    def save(ConceptGroup conceptGroupInstance) {
        if (conceptGroupInstance == null) {
            notFound()
            return
        }

        if (conceptGroupInstance.hasErrors()) {
            respond conceptGroupInstance.errors, view:'create'
            return
        }

        conceptGroupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'conceptGroup.label', default: 'ConceptGroup'), conceptGroupInstance.id])
                redirect conceptGroupInstance
            }
            '*' { respond conceptGroupInstance, [status: CREATED] }
        }
    }

    def edit(ConceptGroup conceptGroupInstance) {
        respond conceptGroupInstance
    }

    @Transactional
    def update() {
		ConceptGroup conceptGroupInstance = ConceptGroup.get(params.id.toLong())
        if (conceptGroupInstance == null) {
            notFound()
            return
        }
		if (params.version) {
			def version = params.version.toLong()
			if (conceptGroupInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: conceptGroupInstance.id
				return
			}
		}
		conceptGroupInstance.properties = params

        if (conceptGroupInstance.hasErrors()) {
            respond conceptGroupInstance.errors, view:'edit'
            return
        }

        conceptGroupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'conceptGroup.label', default: 'ConceptGroup'), conceptGroupInstance.id])
                redirect conceptGroupInstance
            }
            '*'{ respond conceptGroupInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ConceptGroup conceptGroupInstance) {

        if (conceptGroupInstance == null) {
            notFound()
            return
        }

        conceptGroupInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'conceptGroup.label', default: 'ConceptGroup'), conceptGroupInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'conceptGroup.label', default: 'ConceptGroup'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
