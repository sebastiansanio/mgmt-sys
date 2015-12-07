package mgmt.account



import static org.springframework.http.HttpStatus.*

import java.util.List;

import grails.transaction.Transactional
import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class AccountController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	private static List FIELDS = ["name","code","type","currentBalance","dateCreated","lastUpdated"]
	
    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'
        respond Account.list(params), model:[accountInstanceCount: Account.count()]
    }

	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'accounts.label')}.xlsx'");
		
		def headers = FIELDS.collect{
			message(code:'account.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Account.list(), FIELDS)
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
