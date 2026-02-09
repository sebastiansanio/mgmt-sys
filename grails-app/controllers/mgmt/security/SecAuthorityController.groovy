package mgmt.security



import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Transactional(readOnly = true)
class SecAuthorityController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond SecAuthority.list(params), model:[secAuthorityInstanceCount: SecAuthority.count()]
    }

    def show(SecAuthority secAuthorityInstance) {
        respond secAuthorityInstance
    }

    def create() {
        respond new SecAuthority(params)
    }

    @Transactional
    def save(SecAuthority secAuthorityInstance) {
        if (secAuthorityInstance == null) {
            notFound()
            return
        }

        if (secAuthorityInstance.hasErrors()) {
            respond secAuthorityInstance.errors, view:'create'
            return
        }

        secAuthorityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'secAuthority.label', default: 'SecAuthority'), secAuthorityInstance.id])
                redirect secAuthorityInstance
            }
            '*' { respond secAuthorityInstance, [status: CREATED] }
        }
    }

    def edit(SecAuthority secAuthorityInstance) {
        respond secAuthorityInstance
    }

    @Transactional
    def update(SecAuthority secAuthorityInstance) {
        if (secAuthorityInstance == null) {
            notFound()
            return
        }

        if (secAuthorityInstance.hasErrors()) {
            respond secAuthorityInstance.errors, view:'edit'
            return
        }

        secAuthorityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'secAuthority.label', default: 'SecAuthority'), secAuthorityInstance.id])
                redirect secAuthorityInstance
            }
            '*'{ respond secAuthorityInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SecAuthority secAuthorityInstance) {

        if (secAuthorityInstance == null) {
            notFound()
            return
        }

        secAuthorityInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'secAuthority.label', default: 'SecAuthority'), secAuthorityInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'secAuthority.label', default: 'SecAuthority'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
