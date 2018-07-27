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
		movement_item.`total` AS movement_item_total, movement_item.budget_id as budget_id,
		round(coalesce(movement_item.amount,0)/pii.index_value
		*(case when pi.id <> 3 then pii_max.index_value else 1 end),2) amount_indexed,
		round(coalesce(movement_item.iibb,0)/pii.index_value
		*(case when pi.id <> 3 then pii_max.index_value else 1 end),2) iibb_indexed,
		round(coalesce(movement_item.iva,0)/pii.index_value
		*(case when pi.id <> 3 then pii_max.index_value else 1 end) ,2) iva_indexed,
		round(coalesce(movement_item.total,0)/pii.index_value
		*(case when pi.id <> 3 then pii_max.index_value else 1 end),2) total_indexed
   		FROM
		`movement` movement INNER JOIN `movement_item` movement_item ON movement.`id` = movement_item.`movement_id`
		left JOIN `work` work ON movement_item.`work_id` = work.`id`
		INNER JOIN `concept` concept ON movement_item.`concept_id` = concept.`id`
		Inner JOIN `supplier` supplier ON movement_item.`supplier_id` = supplier.`id`

		left outer join price_index pi on pi.id = :priceIndexId
		left outer join price_index_item pii_max on pii_max.index_id = pi.id and pii_max.date = (select max(pii3.date) from price_index_item pii3 where pii3.index_id = pi.id)
		left outer join price_index_item pii on pii.index_id = pi.id 
		and case when pi.frequency = 'daily' then DATE_FORMAT(movement_item.date, '%Y-%m-%d') = DATE_FORMAT(pii.date, '%Y-%m-%d')
		when pi.frequency = 'monthly' then DATE_FORMAT(date_add(movement_item.date,interval -1 month), '%Y-%m-01') = DATE_FORMAT(pii.date, '%Y-%m-01')
		else DATE_FORMAT(movement_item.date, '%Y-%m-01') = DATE_FORMAT(pii.date, '%Y-%m-01') end


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
			fillHeader(["Obra","Operación","Proveedor","Cuenta","Fecha","Descripción","Monto \$","IVA \$", "IIBB", "Otras percepciones","Presupuesto","Neto actualizado","IVA actualizado","IIBB actualizado","Total actualizado"])
			
			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			
			Sql sql = new Sql(dataSource)
			def rows = sql.rows(QUERY,[priceIndexId:params.long('Price_index_id'),supplierId:params.long('Supplier_id'),dateFrom:params.Date_from?DATE_FORMAT.parse(params.Date_from):null,dateTo:params.Date_to?DATE_FORMAT.parse(params.Date_to):null])
			long queryCount = rows.size()
			add(rows, ["work_code","operation","supplier_name","concept_code","movement_date_created","movement_item_description","movement_item_amount","movement_item_iva","movement_item_iibb","movement_item_other_perceptions","budget_id","amount_indexed","iva_indexed","iibb_indexed","total_indexed"])
			sql.close()
			
			
			for(int i = 1;i <= queryCount; i++){
				getCellAt(i, 4).setCellStyle(cellStyle)
			}
			for(int i = 0;i < 14; i++){
				sheet.autoSizeColumn(i)
			}
			
			save(response.outputStream)
		}
	}
	
}
