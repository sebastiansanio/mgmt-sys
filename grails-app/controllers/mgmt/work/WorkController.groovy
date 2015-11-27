package mgmt.work



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class WorkController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
     
		params.sort = params.sort?:'dateCreated'
		params.order = params.order?:'desc'
		params.max = Math.min(max ?: 50, 1000)
        respond Work.list(params), model:[workInstanceCount: Work.count()]
    }

    def show(Work workInstance) {
        respond workInstance
    }

    def create() {
        respond new Work(params)
    }
	
    @Transactional
    def save(Work workInstance) {
        if (workInstance == null) {
            notFound()
            return
        }

        if (workInstance.hasErrors()) {
            respond workInstance.errors, view:'create'
            return
        }

        workInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'work.label', default: 'Work'), workInstance.id])
                redirect workInstance
            }
            '*' { respond workInstance, [status: CREATED] }
        }
    }

    def edit(Work workInstance) {
        respond workInstance
    }

    @Transactional
    def update(Work workInstance) {
        if (workInstance == null) {
            notFound()
            return
        }

        if (workInstance.hasErrors()) {
            respond workInstance.errors, view:'edit'
            return
        }

        workInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'work.label', default: 'Work'), workInstance.id])
                redirect workInstance
            }
            '*'{ respond workInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Work workInstance) {

        if (workInstance == null) {
            notFound()
            return
        }

        workInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'work.label', default: 'Work'), workInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'work.label', default: 'Work'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
