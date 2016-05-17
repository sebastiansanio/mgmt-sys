package mgmt.persons

import groovy.sql.Sql

import java.text.SimpleDateFormat

import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper

import pl.touk.excel.export.WebXlsxExporter

class SupplierExpensesController {
	private static final String QUERY = """	SELECT  CONCAT(upper(movement.type)," ",movement.number,"/",movement.year) AS operation,
		concept.`code` AS concept_code, work.`code` AS work_code, movement.`date_created` AS movement_date_created,
		supplier.`name` AS supplier_name, movement_item.`description` AS movement_item_description,
		movement_item.`amount` AS movement_item_amount, movement_item.`iibb` AS movement_item_iibb,
		movement_item.`iva` AS movement_item_iva, movement_item.`other_perceptions` AS movement_item_other_perceptions,
		movement_item.`total` AS movement_item_total
   FROM
		`movement` movement INNER JOIN `movement_item` movement_item ON movement.`id` = movement_item.`movement_id`
		left JOIN `work` work ON movement_item.`work_id` = work.`id`
		INNER JOIN `concept` concept ON movement_item.`concept_id` = concept.`id`
		Inner JOIN `supplier` supplier ON movement_item.`supplier_id` = supplier.`id`
   where (movement_item.supplier_id = :supplierId or :supplierId = -1)
   and
   (movement.date_created >=  :dateFrom or :dateFrom is null ) and (movement.date_created < :dateTo or :dateTo is null)
   ORDER BY
		supplier.id ASC, work.id ASC
	
	"""
	def dataSource
	
	private static final DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")
	private static final DATE_FORMAT_DOWNLOAD = new SimpleDateFormat("dd-MM-yy")
	
    def index() { 
		
	}
	
	def download(){
		redirect(controller: 'report', action: 'downloadReport', params: params)
	}
	
	def downloadExcel(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='Gastos por proveedor.xlsx'");
		
		new WebXlsxExporter().with {
			fillHeader(["Obra","Operación","Proveedor","Cuenta","Fecha","Descripción","Monto \$","IVA \$", "IIBB", "Otras percepciones"])
			
			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			
			Sql sql = new Sql(dataSource)
			def rows = sql.rows(QUERY,[supplierId:params.long('Supplier_id'),dateFrom:params.Date_from?DATE_FORMAT.parse(params.Date_from):null,dateTo:params.Date_to?DATE_FORMAT.parse(params.Date_to):null])
			long queryCount = rows.size()
			add(rows, ["work_code","operation","supplier_name","concept_code","movement_date_created","movement_item_description","movement_item_amount","movement_item_iva","movement_item_iibb","movement_item_other_perceptions"])
			sql.close()
			
			
			for(int i = 1;i <= queryCount; i++){
				getCellAt(i, 4).setCellStyle(cellStyle)
			}
			for(int i = 0;i < 10; i++){
				sheet.autoSizeColumn(i)
			}
			
			save(response.outputStream)
		}
	}
	
}
