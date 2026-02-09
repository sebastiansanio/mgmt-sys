package mgmt.account



import static org.springframework.http.HttpStatus.*

import java.util.List;

import grails.gorm.transactions.Transactional
import groovy.sql.Sql
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class AccountController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	def dataSource

	private static List FIELDS = ["name","code","type","currentBalance","dateCreated","lastUpdated"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'

		def results = Account.createCriteria().list (params) {
			if(params.statusFilter == "active"){
				def sql = new Sql(dataSource)
				'in'("id",sql.rows("select account_id account from payment group by account_id having sum(amount*multiplier)<>0")*.account)
			}
			order(params.sort, params.order)
		}

		respond results, model:[accountInstanceCount: results.totalCount]
    }

	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"${message(code:'accounts.label')}.xlsx\"");

		def headers = FIELDS.collect{
			message(code:'account.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Account.list(), FIELDS)

			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			for(int i = 1;i <= Account.count(); i++){
				getCellAt(i, 4).setCellStyle(cellStyle)
				getCellAt(i, 5).setCellStyle(cellStyle)
			}
			for(int i = 0;i < FIELDS.size(); i++){
				sheet.autoSizeColumn(i)
			}
			save(response.outputStream)
		}
	}

    def show(Account accountInstance) {
        respond accountInstance
    }

    def create() {
        respond new Account(params)
    }

    @Transactional
    def save(Account accountInstance) {
        if (accountInstance == null) {
            notFound()
            return
        }

        if (accountInstance.hasErrors()) {
            respond accountInstance.errors, view:'create'
            return
        }

        accountInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.id])
                redirect accountInstance
            }
            '*' { respond accountInstance, [status: CREATED] }
        }
    }

    def edit(Account accountInstance) {
        respond accountInstance
    }

    @Transactional
    def update() {
		Account accountInstance = Account.get(params.id.toLong())
        if (accountInstance == null) {
            notFound()
            return
        }
		if (params.version) {
			def version = params.version.toLong()
			if (accountInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: accountInstance.id
				return
			}
		}
		accountInstance.properties = params

        if (accountInstance.hasErrors()) {
            respond accountInstance.errors, view:'edit'
            return
        }

        accountInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.id])
                redirect accountInstance
            }
            '*'{ respond accountInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Account accountInstance) {

        if (accountInstance == null) {
            notFound()
            return
        }
		if (accountInstance.payments){
			flash.error = message(code: 'default.delete.hasMovements.error')
			redirect action: "show", id: accountInstance.id
			return
		}

        accountInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
