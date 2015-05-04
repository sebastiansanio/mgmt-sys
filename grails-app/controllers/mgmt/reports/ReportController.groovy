package mgmt.reports



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import net.sf.jasperreports.engine.JasperCompileManager
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.JasperReport
import net.sf.jasperreports.engine.xml.JRXmlLoader

@Transactional(readOnly = true)
class ReportController {
	
	def dataSource

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
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

	def downloadReport(){
		Report reportInstance = Report.get(params.id.toLong())
		InputStream is = new ByteArrayInputStream(reportInstance.definition)
		JasperReport jasperReport = JasperCompileManager.compileReport(JRXmlLoader.load(is))
		Map variablesValues = new HashMap()
		for(variable in reportInstance.variablesAsList()){
			if(variable.type == "number"){
				variablesValues[variable.jasperVariable] = params[variable.jasperVariable].toLong()
			}
		}
		
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, variablesValues, dataSource.connection)
		byte[] pdf = JasperExportManager.exportReportToPdf(jasperPrint)
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename='${reportInstance.name}.pdf'");
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