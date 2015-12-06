package mgmt.products



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UnitOfMeasurementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond UnitOfMeasurement.list(params), model:[unitOfMeasurementInstanceCount: UnitOfMeasurement.count()]
    }

    def show(UnitOfMeasurement unitOfMeasurementInstance) {
        respond unitOfMeasurementInstance
    }

    def create() {
        respond new UnitOfMeasurement(params)
    }

    @Transactional
    def save(UnitOfMeasurement unitOfMeasurementInstance) {
        if (unitOfMeasurementInstance == null) {
            notFound()
            return
        }

        if (unitOfMeasurementInstance.hasErrors()) {
            respond unitOfMeasurementInstance.errors, view:'create'
            return
        }

        unitOfMeasurementInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'unitOfMeasurement.label', default: 'UnitOfMeasurement'), unitOfMeasurementInstance.id])
                redirect unitOfMeasurementInstance
            }
            '*' { respond unitOfMeasurementInstance, [status: CREATED] }
        }
    }

    def edit(UnitOfMeasurement unitOfMeasurementInstance) {
        respond unitOfMeasurementInstance
    }

    @Transactional
    def update(UnitOfMeasurement unitOfMeasurementInstance) {
        if (unitOfMeasurementInstance == null) {
            notFound()
            return
        }

        if (unitOfMeasurementInstance.hasErrors()) {
            respond unitOfMeasurementInstance.errors, view:'edit'
            return
        }

        unitOfMeasurementInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'unitOfMeasurement.label', default: 'UnitOfMeasurement'), unitOfMeasurementInstance.id])
                redirect unitOfMeasurementInstance
            }
            '*'{ respond unitOfMeasurementInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(UnitOfMeasurement unitOfMeasurementInstance) {

        if (unitOfMeasurementInstance == null) {
            notFound()
            return
        }

        unitOfMeasurementInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'unitOfMeasurement.label', default: 'UnitOfMeasurement'), unitOfMeasurementInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'unitOfMeasurement.label', default: 'UnitOfMeasurement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
