package mgmt.persons



import static org.springframework.http.HttpStatus.*

import java.util.List;
import pl.touk.excel.export.WebXlsxExporter

import grails.transaction.Transactional

@Transactional(readOnly = true)
class ClientController {

	private static List FIELDS = ["name","businessName","cuit","address","location",
		"province","zipCode","note","dateCreated","lastUpdated"]
	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond Client.list(params), model:[clientInstanceCount: Client.count()]
    }
	
	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'menu.client.label')}.xlsx'");
		
		def headers = FIELDS.collect{
			message(code:'client.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Client.list(), FIELDS)
			save(response.outputStream)
		}
	}

    def show(Client clientInstance) {
        respond clientInstance
    }

    def create() {
        respond new Client(params)
    }

    @Transactional
    def save(Client clientInstance) {
        if (clientInstance == null) {
            notFound()
            return
        }

        if (clientInstance.hasErrors()) {
            respond clientInstance.errors, view:'create'
            return
        }

        clientInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'client.label', default: 'Client'), clientInstance.id])
                redirect clientInstance
            }
            '*' { respond clientInstance, [status: CREATED] }
        }
    }

    def edit(Client clientInstance) {
        respond clientInstance
    }

    @Transactional
    def update() {
		Client clientInstance = Client.get(params.id.toLong())
        if (clientInstance == null) {
            notFound()
            return
        }
		if (params.version) {
			def version = params.version.toLong()
			if (clientInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: clientInstance.id
				return
			}
		}
		clientInstance.properties = params

        if (clientInstance.hasErrors()) {
            respond clientInstance.errors, view:'edit'
            return
        }

        clientInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'client.label', default: 'Client'), clientInstance.id])
                redirect clientInstance
            }
            '*'{ respond clientInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Client clientInstance) {

        if (clientInstance == null) {
            notFound()
            return
        }

        clientInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'client.label', default: 'Client'), clientInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
