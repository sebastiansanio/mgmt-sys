package mgmt.security



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RequestmapController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def springSecurityService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond Requestmap.list(params), model:[requestmapInstanceCount: Requestmap.count()]
    }

    def show(Requestmap requestmapInstance) {
        respond requestmapInstance
    }

    def create() {
        respond new Requestmap(params)
    }

    @Transactional
    def save(Requestmap requestmapInstance) {
        if (requestmapInstance == null) {
            notFound()
            return
        }

        if (requestmapInstance.hasErrors()) {
            respond requestmapInstance.errors, view:'create'
            return
        }

        requestmapInstance.save flush:true
		
		springSecurityService.clearCachedRequestmaps()
																																																																																																																					
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'requestmap.label', default: 'Requestmap'), requestmapInstance.id])
                redirect requestmapInstance
            }
            '*' { respond requestmapInstance, [status: CREATED] }
        }
    }
	
    def edit(Requestmap requestmapInstance) {
        respond requestmapInstance
    }

    @Transactional
    def update(Requestmap requestmapInstance) {
        if (requestmapInstance == null) {
            notFound()
            return
        }

        if (requestmapInstance.hasErrors()) {
            respond requestmapInstance.errors, view:'edit'
            return
        }

        requestmapInstance.save flush:true
		
		springSecurityService.clearCachedRequestmaps()

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'requestmap.label', default: 'Requestmap'), requestmapInstance.id])
                redirect requestmapInstance
            }
            '*'{ respond requestmapInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Requestmap requestmapInstance) {

        if (requestmapInstance == null) {
            notFound()
            return
        }

        requestmapInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'requestmap.label', default: 'Requestmap'), requestmapInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'requestmap.label', default: 'Requestmap'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
