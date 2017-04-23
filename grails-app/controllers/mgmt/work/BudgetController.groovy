package mgmt.work



import static org.springframework.http.HttpStatus.*

import java.util.List;

import mgmt.persons.Client;
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BudgetController {
	
	private static List FIELDS = ["code","client","name","directCosts","iibbPercentage","iibbAmount",
	"indirectOverheadPercentage","indirectOverheadAmount","profitPercentage","profitAmount",
	"ivaPercentage","totalAmount","hasWork","dateCreated","lastUpdated"]
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	@Transactional
	def generateWork(Budget budgetInstance) {
		if(budgetInstance.hasWork){
			flash.error = message(code: 'default.hasWork.error')
			redirect budgetInstance
			return
		}
		
		budgetInstance.hasWork = true
		Work work = new Work()
		work.client = budgetInstance.client
		work.name = budgetInstance.name
		work.type = 'building'
		work.budget = budgetInstance
		budgetInstance.save flush: true
		work.save flush:true
		
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [message(code: 'work.label'), work.id])
				redirect work
			}
			'*' { respond work, [status: CREATED] }
		}
		
	}
	
    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'dateCreated'
		params.order = params.order ?: 'desc'
        respond Budget.list(params), model:[budgetInstanceCount: Budget.count()]
    }
	
	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'menu.budget.label')}.xlsx'");
		
		def headers = FIELDS.collect{
			message(code:'budget.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Budget.list(), FIELDS)
			
			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			for(int i = 1;i <= Budget.count(); i++){
				getCellAt(i, 12).setCellStyle(cellStyle)
				getCellAt(i, 13).setCellStyle(cellStyle)
			}
			for(int i = 0;i < FIELDS.size(); i++){
				sheet.autoSizeColumn(i)
			}
			
			save(response.outputStream)
		}
	}
	
	def search(Integer max) {
		params.max = Math.min(max ?: 100, 1000)
		String nameQuery = "%"+params.name+"%"
		respond Budget.findAllByNameLike(nameQuery,params), model:[budgetInstanceCount: Budget.countByNameLike(nameQuery)],  view:'index'
	}

    def show(Budget budgetInstance) {
        respond budgetInstance
    }

    def create() {
        respond new Budget(params)
    }

    @Transactional
    def save() {
		Budget budgetInstance = new Budget(params)
        if (budgetInstance == null) {
            notFound()
            return
        }
		
		budgetInstance.items = budgetInstance.items - [null]
		budgetInstance.validate()

        if (budgetInstance.hasErrors()) {
            respond budgetInstance.errors, view:'create'
            return
        }

        budgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'budget.label', default: 'Budget'), budgetInstance.id])
                redirect action:"edit", id: budgetInstance.id, method:"GET"
            }
            '*' { respond budgetInstance, [status: CREATED] }
        }
    }

    def edit(Budget budgetInstance) {
        respond budgetInstance
    }

    @Transactional
    def update() {
		Budget budgetInstance = Budget.get(params.id.toLong())
		if (budgetInstance == null) {
			notFound()
			return
		}
		
		if (params.version) {
			def version = params.version.toLong()
			if (budgetInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: budgetInstance.id
				return
			}
		}
				
		for (item in budgetInstance.items) {
			item.delete()
		}
		budgetInstance.items.clear()
		budgetInstance.properties = params
		budgetInstance.items = budgetInstance.items - [null]
		budgetInstance.validate()
        if (budgetInstance.hasErrors()) {
            respond budgetInstance.errors, view:'edit'
            return
        }

        budgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'budget.label', default: 'Budget'), budgetInstance.id])
                redirect action:"edit", id: budgetInstance.id, method:"GET"
            }
            '*'{ respond budgetInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Budget budgetInstance) {

        if (budgetInstance == null) {
            notFound()
            return
        }

        budgetInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'budget.label', default: 'Budget'), budgetInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'budget.label', default: 'Budget'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
