package mgmt.reports



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

import mgmt.products.UnitOfMeasurement;
import net.sf.jasperreports.engine.JasperCompileManager
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.JasperReport
import net.sf.jasperreports.engine.xml.JRXmlLoader

@Transactional(readOnly = true)
class ReportController {

	private static final DateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")

	def dataSource

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        respond Report.list(params), model:[reportInstanceCount: Report.count()]
    }

    def show(Report reportInstance) {
        respond reportInstance
    }

    def create() {
        respond new Report(params)
    }

    @Transactional
    def save(Report reportInstance) {
        if (reportInstance == null) {
            notFound()
            return
        }

        if (reportInstance.hasErrors()) {
            respond reportInstance.errors, view:'create'
            return
        }

        reportInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'report.label', default: 'Report'), reportInstance.id])
                redirect reportInstance
            }
            '*' { respond reportInstance, [status: CREATED] }
        }
    }

	def edit(Report reportInstance) {
		respond reportInstance
	}

	@Transactional
	def update() {
		Report reportInstance = Report.get(params.id.toLong())
		if (reportInstance == null) {
			notFound()
			return
		}
		if (params.version) {
			def version = params.version.toLong()
			if (reportInstance.version > version) {
				flash.error = message(code: "default.optimistic.locking.failure")
				redirect action: "edit", id: reportInstance.id
				return
			}
		}
		reportInstance.properties = params
		if (reportInstance.hasErrors()) {
			respond reportInstance.errors, view:'edit'
			return
		}

		reportInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'report.label'), reportInstance.id])
				redirect reportInstance
			}
			'*'{ respond reportInstance, [status: OK] }
		}
	}

	def downloadReport(){
		Report reportInstance = Report.get(params.id.toLong())
		InputStream is = new ByteArrayInputStream(reportInstance.definition)
		JasperReport jasperReport = JasperCompileManager.compileReport(JRXmlLoader.load(is))
		Map variablesValues = new HashMap()
		for(variable in reportInstance.variablesAsList()){
			if(params[variable.jasperVariable]){
				if(variable.type == "number"){
					variablesValues[variable.jasperVariable] = params[variable.jasperVariable].toLong()
				}
				if(variable.type == "date"){
					variablesValues[variable.jasperVariable] = DATE_FORMAT.parse(params[variable.jasperVariable])
				}
				if(variable.type == "string"){
					variablesValues[variable.jasperVariable] = params[variable.jasperVariable]
				}
			}
		}
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, variablesValues, dataSource.connection)
		byte[] pdf = JasperExportManager.exportReportToPdf(jasperPrint)
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "inline; filename=\"${reportInstance.name}.pdf\"");
		response.outputStream << pdf
	}

    @Transactional
    def delete(Report reportInstance) {

        if (reportInstance == null) {
            notFound()
            return
        }

        reportInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Report.label', default: 'Report'), reportInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'report.label', default: 'Report'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
