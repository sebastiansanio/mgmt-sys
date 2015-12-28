package mgmt.work



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class WorkController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		params.sort = params.sort?:[type:'desc', code:'desc']
		params.order = params.order?:'desc'
		params.max = Math.min(max ?: 100, 1000)
        respond Work.list(params), model:[workInstanceCount: Work.count()]
    }

    def show(Work workInstance) {
        respond workInstance
    }

    def create() {
        respond new Work(params)
    }
	
	def search(Integer max) {
		params.max = Math.min(max ?: 100, 1000)
		Long code = params.long('code')
		if(!code){
			redirect action: 'index'
		}
		
		respond Work.findAllByCode(code,params), model:[workInstanceCount: Work.countByCode(code)],  view:'index'
	}
	
    @Transactional
    def save(Work workInstance) {
        if (workInstance == null) {
            notFound()
            return
        }

        if (workInstance.hasErrors()) {
            respond workInstance.errors, view:'create'
            return
        }

        workInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'work.label', default: 'Work'), workInstance.id])
                redirect workInstance
            }
            '*' { respond workInstance, [status: CREATED] }
        }
    }

    def edit(Work workInstance) {
        respond workInstance
    }

    @Transactional
    def update() {
		Work workInstance = Work.get(params.id.toLong())
        if (workInstance == null) {
            notFound()
            return
        }
		if (params.version) {
			def version = params.version.toLong()
			if (workInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: workInstance.id
				return
			}
		}
		workInstance.properties = params

        if (workInstance.hasErrors()) {
            respond workInstance.errors, view:'edit'
            return
        }

        workInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'work.label', default: 'Work'), workInstance.id])
                redirect workInstance
            }
            '*'{ respond workInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Work workInstance) {

        if (workInstance == null) {
            notFound()
            return
        }

        workInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'work.label', default: 'Work'), workInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'work.label', default: 'Work'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	def download(){
		redirect controller: 'report', action: 'downloadReport', id: mgmt.reports.Report.findByCode('worksList').id
	}
	
	@Transactional
	def close(){
		def workInstance = Work.get(params.id.toLong())
		if (workInstance == null) {
			notFound()
			return
		}
		workInstance.finished = true
		workInstance.save flush: true
		flash.message = message(code: 'work.close.message')
		redirect action:"index", method:"GET"
		
	}
	@Transactional
	def open(){
		def workInstance = Work.get(params.id.toLong())
		if (workInstance == null) {
			notFound()
			return
		}
		workInstance.finished = false
		workInstance.save flush: true
		flash.message = message(code: 'work.open.message')
		redirect action:"index", method:"GET"
	}
}
