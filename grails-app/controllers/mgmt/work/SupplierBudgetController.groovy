package mgmt.work



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SupplierBudgetController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		params.sort = params.sort?:'id'
		params.order = params.order?:'desc'
        params.max = Math.min(max ?: 100, 1000)
		
		def results = SupplierBudget.createCriteria().list (params) {
			if(params.supplierFilter){
				eq("supplier", mgmt.persons.Supplier.get(params.supplierFilter.toLong()))
			}
			if(params.conceptFilter){
				eq("concept", mgmt.concept.Concept.get(params.conceptFilter.toLong()))
			}
			order(params.sort, params.order)
		}
		
        respond results, model:[supplierBudgetInstanceCount: results.totalCount]
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
		supplierBudgetInstance.validate()
        if (supplierBudgetInstance.hasErrors()) {
            respond supplierBudgetInstance.errors, view:'create'
            return
        }

        supplierBudgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'supplierBudget.label', default: 'SupplierBudget'), supplierBudgetInstance.id])
				redirect action:"edit", id: supplierBudgetInstance.id, method:"GET"
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
		supplierBudgetInstance.validate()
        if (supplierBudgetInstance.hasErrors()) {
            respond supplierBudgetInstance.errors, view:'edit'
            return
        }

        supplierBudgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'supplierBudget.label', default: 'SupplierBudget'), supplierBudgetInstance.id])
                redirect action:"edit", id: supplierBudgetInstance.id, method:"GET"
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
	
	@Transactional
	def close(){
		def supplierBudgetInstance = SupplierBudget.get(params.id.toLong())
		if (supplierBudgetInstance == null) {
			notFound()
			return
		}
		supplierBudgetInstance.closed = true
		supplierBudgetInstance.save flush: true
		flash.message = message(code: 'supplierBudget.close.message')
		redirect action:"index", method:"GET", params:params
		
	}
	@Transactional
	def open(){
		def supplierBudgetInstance = SupplierBudget.get(params.id.toLong())
		if (supplierBudgetInstance == null) {
			notFound()
			return
		}
		supplierBudgetInstance.closed = false
		supplierBudgetInstance.save flush: true
		flash.message = message(code: 'supplierBudget.open.message')
		redirect action:"index", method:"GET", params:params
	}
}
