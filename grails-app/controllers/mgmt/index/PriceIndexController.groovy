package mgmt.index



import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Transactional(readOnly = true)
class PriceIndexController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PriceIndex.list(params), model:[priceIndexInstanceCount: PriceIndex.count()]
    }

    def show(PriceIndex priceIndexInstance) {
        respond priceIndexInstance
    }

    def create() {
        respond new PriceIndex(params)
    }

    @Transactional
    def save(PriceIndex priceIndexInstance) {
        if (priceIndexInstance == null) {
            notFound()
            return
        }

        if (priceIndexInstance.hasErrors()) {
            respond priceIndexInstance.errors, view:'create'
            return
        }

        priceIndexInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'priceIndex.label', default: 'PriceIndex'), priceIndexInstance.id])
                redirect priceIndexInstance
            }
            '*' { respond priceIndexInstance, [status: CREATED] }
        }
    }

    def edit(PriceIndex priceIndexInstance) {
        respond priceIndexInstance
    }

    @Transactional
    def update(PriceIndex priceIndexInstance) {
        if (priceIndexInstance == null) {
            notFound()
            return
        }

        if (priceIndexInstance.hasErrors()) {
            respond priceIndexInstance.errors, view:'edit'
            return
        }

        priceIndexInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PriceIndex.label', default: 'PriceIndex'), priceIndexInstance.id])
                redirect priceIndexInstance
            }
            '*'{ respond priceIndexInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PriceIndex priceIndexInstance) {

        if (priceIndexInstance == null) {
            notFound()
            return
        }

        priceIndexInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PriceIndex.label', default: 'PriceIndex'), priceIndexInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'priceIndex.label', default: 'PriceIndex'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
