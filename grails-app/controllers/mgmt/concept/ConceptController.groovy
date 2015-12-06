package mgmt.concept



import static org.springframework.http.HttpStatus.*

import java.util.List;

import grails.transaction.Transactional
import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class ConceptController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	private static List FIELDS = ["code","description","conceptAccount","conceptGroup","dateCreated","lastUpdated"]
	
	
    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond Concept.list(params), model:[conceptInstanceCount: Concept.count()]
    }
	
	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'menu.concept.label')}.xlsx'");
		
		def headers = FIELDS.collect{
			message(code:'concept.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Concept.list(), FIELDS)
			save(response.outputStream)
		}
	}

    def show(Concept conceptInstance) {
        respond conceptInstance
    }

    def create() {
        respond new Concept(params)
    }

    @Transactional
    def save(Concept conceptInstance) {
        if (conceptInstance == null) {
            notFound()
            return
        }

        if (conceptInstance.hasErrors()) {
            respond conceptInstance.errors, view:'create'
            return
        }

        conceptInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'concept.label', default: 'Concept'), conceptInstance.id])
                redirect conceptInstance
            }
            '*' { respond conceptInstance, [status: CREATED] }
        }
    }

    def edit(Concept conceptInstance) {
        respond conceptInstance
    }

    @Transactional
    def update(Concept conceptInstance) {
        if (conceptInstance == null) {
            notFound()
            return
        }

        if (conceptInstance.hasErrors()) {
            respond conceptInstance.errors, view:'edit'
            return
        }

        conceptInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'concept.label', default: 'Concept'), conceptInstance.id])
                redirect conceptInstance
            }
            '*'{ respond conceptInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Concept conceptInstance) {

        if (conceptInstance == null) {
            notFound()
            return
        }

        conceptInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'concept.label', default: 'Concept'), conceptInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'concept.label', default: 'Concept'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
