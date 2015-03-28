package mgmt.invoice



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InvoiceTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 50, 1000)
        respond InvoiceType.list(params), model:[invoiceTypeInstanceCount: InvoiceType.count()]
    }

    def show(InvoiceType invoiceTypeInstance) {
        respond invoiceTypeInstance
    }

    def create() {
        respond new InvoiceType(params)
    }

    @Transactional
    def save(InvoiceType invoiceTypeInstance) {
        if (invoiceTypeInstance == null) {
            notFound()
            return
        }

        if (invoiceTypeInstance.hasErrors()) {
            respond invoiceTypeInstance.errors, view:'create'
            return
        }

        invoiceTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'invoiceType.label', default: 'InvoiceType'), invoiceTypeInstance.id])
                redirect invoiceTypeInstance
            }
            '*' { respond invoiceTypeInstance, [status: CREATED] }
        }
    }

    def edit(InvoiceType invoiceTypeInstance) {
        respond invoiceTypeInstance
    }

    @Transactional
    def update(InvoiceType invoiceTypeInstance) {
        if (invoiceTypeInstance == null) {
            notFound()
            return
        }

        if (invoiceTypeInstance.hasErrors()) {
            respond invoiceTypeInstance.errors, view:'edit'
            return
        }

        invoiceTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InvoiceType.label', default: 'InvoiceType'), invoiceTypeInstance.id])
                redirect invoiceTypeInstance
            }
            '*'{ respond invoiceTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InvoiceType invoiceTypeInstance) {

        if (invoiceTypeInstance == null) {
            notFound()
            return
        }

        invoiceTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InvoiceType.label', default: 'InvoiceType'), invoiceTypeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceType.label', default: 'InvoiceType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
