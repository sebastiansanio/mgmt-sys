package mgmt.persons



import static org.springframework.http.HttpStatus.*

import java.util.Date;

import grails.transaction.Transactional
import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class SupplierController {

	private static List FIELDS = ["name","businessName","cuit","address","location",
		"province","zipCode","note","dateCreated","lastUpdated"]
		
	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 50, 1000)
        respond Supplier.list(params), model:[supplierInstanceCount: Supplier.count()]
    }
	
	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'menu.supplier.label')}.xls'");
		
		def headers = FIELDS.collect{
			message(code:'supplier.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Supplier.list(), FIELDS)
			save(response.outputStream)
		}
	}
	
	def search(Integer max) {
		params.max = Math.min(max ?: 50, 1000)
		String nameQuery = "%"+params.name+"%"
		respond Supplier.findAllByNameLike(nameQuery,params), model:[supplierInstanceCount: Supplier.countByNameLike(nameQuery)],  view:'index'
	}

    def show(Supplier supplierInstance) {
        respond supplierInstance
    }

    def create() {
        respond new Supplier(params)
    }

    @Transactional
    def save(Supplier supplierInstance) {
        if (supplierInstance == null) {
            notFound()
            return
        }

        if (supplierInstance.hasErrors()) {
            respond supplierInstance.errors, view:'create'
            return
        }

        supplierInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
                redirect supplierInstance
            }
            '*' { respond supplierInstance, [status: CREATED] }
        }
    }

    def edit(Supplier supplierInstance) {
        respond supplierInstance
    }

    @Transactional
    def update(Supplier supplierInstance) {
        if (supplierInstance == null) {
            notFound()
            return
        }

        if (supplierInstance.hasErrors()) {
            respond supplierInstance.errors, view:'edit'
            return
        }

        supplierInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Supplier.label', default: 'Supplier'), supplierInstance.id])
                redirect supplierInstance
            }
            '*'{ respond supplierInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Supplier supplierInstance) {

        if (supplierInstance == null) {
            notFound()
            return
        }

        supplierInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
