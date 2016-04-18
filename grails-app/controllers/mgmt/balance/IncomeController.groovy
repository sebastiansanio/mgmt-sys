package mgmt.balance

import groovy.sql.Sql
import java.text.SimpleDateFormat
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter

class IncomeController {

	def dataSource
	
	private static final DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")
	private static final DATE_FORMAT_DOWNLOAD = new SimpleDateFormat("dd-MM-yy")
	
	private static final FIELDS = ["account","movement","movement.dateCreated","paymentDate",
		"signedAmount","checkNumber","note","movement.lastUpdated"]
	private static final String QUERY = """	SELECT movement.date_created AS movement_date_created,coalesce(movement_item.`amount`,0) AS movement_item_amount,movement_item.`date` AS movement_item_date,
		     movement_item.`date_created` AS movement_item_date_created,movement_item.`description` AS movement_item_description,
		     coalesce(movement_item.`iibb`,0) AS movement_item_iibb,coalesce(movement_item.`iva`,0) AS movement_item_iva,
		     coalesce(movement_item.`total`,0) AS movement_item_total, movement.`number` AS movement_number,
		     CONCAT(upper(movement.`type`)," ",movement.`number`,"/",movement.`year`) AS operation,
		     movement.`note` AS movement_note, work.`code` AS work_code,
		     work.`name` AS work_name, concept.`code` AS concept_code
		FROM
		     `movement` movement INNER JOIN `movement_item` movement_item ON movement.`id` = movement_item.`movement_id`
		     left JOIN `work` work ON movement_item.`work_id` = work.`id`
		     INNER JOIN `concept` concept ON movement_item.`concept_id` = concept.`id`
		     left JOIN `supplier` supplier ON movement_item.`supplier_id` = supplier.`id`
		LEFT OUTER JOIN concept_group cg ON concept.concept_group_id = cg.id
		where (movement.date_created >=  :dateFrom or :dateFrom is null ) and (movement.date_created < :dateTo or :dateTo is null)
		and ((:workId <> -1 and work.id = :workId) or (:workId = -1 and work.id is null))
		and movement_item.multiplier = 1
		ORDER BY work.code ASC, cg.name asc, concept.code asc, movement.date_created desc
	"""
	
    def index() { }
	
	def download(){
		redirect(controller: 'report', action: 'downloadReport', params: params)
		
	}
	
	def downloadExcel(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='Ingresos.xlsx'");
		
		new WebXlsxExporter().with {
			fillHeader(["Obra","Operación","Cuenta","Fecha","Descripción","Monto \$","IVA \$", "IIBB"])
			
			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			
			Sql sql = new Sql(dataSource)
			
			def rows = sql.rows(QUERY,[workId:params.long('Work_id'),dateFrom:params.Date_from?DATE_FORMAT.parse(params.Date_from):null,dateTo:params.Date_to?DATE_FORMAT.parse(params.Date_to):null])
			long queryCount = rows.size()
			add(rows, ["work_code","operation","concept_code","movement_date_created","movement_item_description","movement_item_amount","movement_item_iva","movement_item_iibb"])
			sql.close()
			
			
			for(int i = 1;i <= queryCount; i++){
				getCellAt(i, 3).setCellStyle(cellStyle)
			}
			for(int i = 0;i < 8; i++){
				sheet.autoSizeColumn(i)
			}
			
			save(response.outputStream)
		}
	}
}
