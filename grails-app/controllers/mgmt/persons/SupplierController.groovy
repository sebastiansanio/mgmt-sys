package mgmt.persons



import static org.springframework.http.HttpStatus.*

import java.util.Date;

import grails.transaction.Transactional
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class SupplierController {

	private static List FIELDS = ["name","businessName","cuit","address","location",
		"province","zipCode","note","dateCreated","lastUpdated"]
		
	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'
        respond Supplier.list(params), model:[supplierInstanceCount: Supplier.count()]
    }
	
	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'menu.supplier.label')}.xlsx'");
		
		def headers = FIELDS.collect{
			message(code:'supplier.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Supplier.list(), FIELDS)
			
			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			for(int i = 1;i <= Supplier.count(); i++){
				getCellAt(i, 8).setCellStyle(cellStyle)
				getCellAt(i, 9).setCellStyle(cellStyle)
			}
			for(int i = 0;i < FIELDS.size(); i++){
				sheet.autoSizeColumn(i)
			}
			
			save(response.outputStream)
		}
	}
	
	def search(Integer max) {
		params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'
		String nameQuery = "%"+params.name+"%"
		respond Supplier.findAllByNameLikeOrBusinessNameLike(nameQuery,nameQuery,params), model:[supplierInstanceCount: Supplier.countByNameLike(nameQuery)],  view:'index'
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
    def update() {
		Supplier supplierInstance = Supplier.get(params.id.toLong())
        if (supplierInstance == null) {
            notFound()
            return
        }
		if (params.version) {
			def version = params.version.toLong()
			if (supplierInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: supplierInstance.id
				return
			}
		}
		supplierInstance.properties = params

        if (supplierInstance.hasErrors()) {
            respond supplierInstance.errors, view:'edit'
            return
        }

        supplierInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
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
		if (supplierInstance.movements){
			flash.error = message(code: 'default.delete.hasMovements.error')
			redirect action: "show", id: supplierInstance.id
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
