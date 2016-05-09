package mgmt.config



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ParameterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Parameter.list(params), model:[parameterInstanceCount: Parameter.count()]
    }

    def show(Parameter parameterInstance) {
        respond parameterInstance
    }

    def create() {
        respond new Parameter(params)
    }

    @Transactional
    def save(Parameter parameterInstance) {
        if (parameterInstance == null) {
            notFound()
            return
        }

        if (parameterInstance.hasErrors()) {
            respond parameterInstance.errors, view:'create'
            return
        }

        parameterInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'parameter.label', default: 'Parameter'), parameterInstance.id])
                redirect action:"index", method:"GET"
            }
            '*' { respond parameterInstance, [status: CREATED] }
        }
    }

    def edit(Parameter parameterInstance) {
        respond parameterInstance
    }

    @Transactional
    def update(Parameter parameterInstance) {
        if (parameterInstance == null) {
            notFound()
            return
        }

        if (parameterInstance.hasErrors()) {
            respond parameterInstance.errors, view:'edit'
            return
        }

        parameterInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Parameter.label', default: 'Parameter'), parameterInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ respond parameterInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Parameter parameterInstance) {

        if (parameterInstance == null) {
            notFound()
            return
        }

        parameterInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Parameter.label', default: 'Parameter'), parameterInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
