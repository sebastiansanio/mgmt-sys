package mgmt.work



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BudgetController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 50, 1000)
        respond Budget.list(params), model:[budgetInstanceCount: Budget.count()]
    }

    def show(Budget budgetInstance) {
        respond budgetInstance
    }

    def create() {
        respond new Budget(params)
    }

    @Transactional
    def save(Budget budgetInstance) {
        if (budgetInstance == null) {
            notFound()
            return
        }

        if (budgetInstance.hasErrors()) {
            respond budgetInstance.errors, view:'create'
            return
        }

        budgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'budget.label', default: 'Budget'), budgetInstance.id])
                redirect budgetInstance
            }
            '*' { respond budgetInstance, [status: CREATED] }
        }
    }

    def edit(Budget budgetInstance) {
        respond budgetInstance
    }

    @Transactional
    def update(Budget budgetInstance) {
        if (budgetInstance == null) {
            notFound()
            return
        }

        if (budgetInstance.hasErrors()) {
            respond budgetInstance.errors, view:'edit'
            return
        }

        budgetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Budget.label', default: 'Budget'), budgetInstance.id])
                redirect budgetInstance
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
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Budget.label', default: 'Budget'), budgetInstance.id])
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
