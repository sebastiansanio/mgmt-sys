package mgmt.work



import static org.springframework.http.HttpStatus.*
import mgmt.persons.Client;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BudgetController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	@Transactional
	def generateWork(Budget budgetInstance) {
		if(budgetInstance.hasWork){
			flash.error = message(code: 'default.hasWork.error')
			redirect budgetInstance
			return
		}
		
		Work work = new Work()
		work.client = budgetInstance.client
		work.name = budgetInstance.name
		work.type = 'building'
		work.budget = budgetInstance
		budgetInstance.hasWork = true
		work.save flush:true
		budgetInstance.save flush: true
		
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
        respond Budget.list(params), model:[budgetInstanceCount: Budget.count()]
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
                redirect budgetInstance
            }
            '*' { respond budgetInstance, [status: CREATED] }
        }
    }

    def edit(Budget budgetInstance) {
		if(budgetInstance.hasWork){
			flash.error = message(code: 'budget.closed.error')
			redirect budgetInstance
			return
		}
        respond budgetInstance
    }

    @Transactional
    def update() {
		Budget budgetInstance = Budget.get(params.id.toLong())
		if (budgetInstance == null) {
			notFound()
			return
		}
		if(budgetInstance.hasWork){
			flash.error = message(code: 'budget.closed.error')
			redirect budgetInstance
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
