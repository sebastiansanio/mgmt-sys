package mgmt.work



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SupplierBudgetController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		params.sort = params.sort?:'dateCreated'
		params.order = params.order?:'desc'
        params.max = Math.min(max ?: 100, 1000)
        respond SupplierBudget.list(params), model:[supplierBudgetInstanceCount: SupplierBudget.count()]
    }

    def show(SupplierBudget supplierBudgetInstance) {
        respond supplierBudgetInstance
    }

    def create() {
        respond new SupplierBudget(params)
    }

    @Transactional
    def save(SupplierBudget supplierBudgetInstance) {
        if (supplierBudgetInstance == null) {
            notFound()
            return
        }

        if (supplierBudgetInstance.hasErrors()) {
            respond supplierBudgetInstance.errors, view:'create'
            return
        }

        supplierBudgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'supplierBudget.label', default: 'SupplierBudget'), supplierBudgetInstance.id])
                redirect supplierBudgetInstance
            }
            '*' { respond supplierBudgetInstance, [status: CREATED] }
        }
    }

    def edit(SupplierBudget supplierBudgetInstance) {
        respond supplierBudgetInstance
    }

    @Transactional
    def update() {
		SupplierBudget supplierBudgetInstance = SupplierBudget.get(params.id.toLong())
        if (supplierBudgetInstance == null) {
            notFound()
            return
        }
		if (params.version) {
			def version = params.version.toLong()
			if (supplierBudgetInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: supplierBudgetInstance.id
				return
			}
		}
		supplierBudgetInstance.properties = params

        if (supplierBudgetInstance.hasErrors()) {
            respond supplierBudgetInstance.errors, view:'edit'
            return
        }

        supplierBudgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'upplierBudget.label', default: 'SupplierBudget'), supplierBudgetInstance.id])
                redirect supplierBudgetInstance
            }
            '*'{ respond supplierBudgetInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SupplierBudget supplierBudgetInstance) {

        if (supplierBudgetInstance == null) {
            notFound()
            return
        }

        supplierBudgetInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'supplierBudget.label', default: 'SupplierBudget'), supplierBudgetInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplierBudget.label', default: 'SupplierBudget'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
