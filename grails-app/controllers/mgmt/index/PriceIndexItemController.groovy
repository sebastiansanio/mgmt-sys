package mgmt.index



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PriceIndexItemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PriceIndexItem.list(params), model:[priceIndexItemInstanceCount: PriceIndexItem.count()]
    }

    def show(PriceIndexItem priceIndexItemInstance) {
        respond priceIndexItemInstance
    }

    def create() {
        respond new PriceIndexItem(params)
    }

    @Transactional
    def save(PriceIndexItem priceIndexItemInstance) {
        if (priceIndexItemInstance == null) {
            notFound()
            return
        }

        if (priceIndexItemInstance.hasErrors()) {
            respond priceIndexItemInstance.errors, view:'create'
            return
        }

        priceIndexItemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'priceIndexItem.label', default: 'PriceIndexItem'), priceIndexItemInstance.id])
                redirect priceIndexItemInstance
            }
            '*' { respond priceIndexItemInstance, [status: CREATED] }
        }
    }

    def edit(PriceIndexItem priceIndexItemInstance) {
        respond priceIndexItemInstance
    }

    @Transactional
    def update(PriceIndexItem priceIndexItemInstance) {
        if (priceIndexItemInstance == null) {
            notFound()
            return
        }

        if (priceIndexItemInstance.hasErrors()) {
            respond priceIndexItemInstance.errors, view:'edit'
            return
        }

        priceIndexItemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PriceIndexItem.label', default: 'PriceIndexItem'), priceIndexItemInstance.id])
                redirect priceIndexItemInstance
            }
            '*'{ respond priceIndexItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PriceIndexItem priceIndexItemInstance) {

        if (priceIndexItemInstance == null) {
            notFound()
            return
        }

        priceIndexItemInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PriceIndexItem.label', default: 'PriceIndexItem'), priceIndexItemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'priceIndexItem.label', default: 'PriceIndexItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
