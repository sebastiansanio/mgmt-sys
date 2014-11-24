package mgmt.payment



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PaymentOrderController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PaymentOrder.list(params), model:[paymentOrderInstanceCount: PaymentOrder.count()]
    }

    def show(PaymentOrder paymentOrderInstance) {
        respond paymentOrderInstance
    }

    def create() {
        respond new PaymentOrder(params)
    }

    @Transactional
    def save(PaymentOrder paymentOrderInstance) {
        if (paymentOrderInstance == null) {
            notFound()
            return
        }

        if (paymentOrderInstance.hasErrors()) {
            respond paymentOrderInstance.errors, view:'create'
            return
        }

        paymentOrderInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'paymentOrder.label', default: 'PaymentOrder'), paymentOrderInstance.id])
                redirect paymentOrderInstance
            }
            '*' { respond paymentOrderInstance, [status: CREATED] }
        }
    }

    def edit(PaymentOrder paymentOrderInstance) {
        respond paymentOrderInstance
    }

    @Transactional
    def update(PaymentOrder paymentOrderInstance) {
        if (paymentOrderInstance == null) {
            notFound()
            return
        }

        if (paymentOrderInstance.hasErrors()) {
            respond paymentOrderInstance.errors, view:'edit'
            return
        }

        paymentOrderInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PaymentOrder.label', default: 'PaymentOrder'), paymentOrderInstance.id])
                redirect paymentOrderInstance
            }
            '*'{ respond paymentOrderInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PaymentOrder paymentOrderInstance) {

        if (paymentOrderInstance == null) {
            notFound()
            return
        }

        paymentOrderInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PaymentOrder.label', default: 'PaymentOrder'), paymentOrderInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'paymentOrder.label', default: 'PaymentOrder'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
