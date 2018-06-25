package mgmt.balance
import groovy.sql.Sql
import java.text.SimpleDateFormat
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter

class MovementsExportController {

	def dataSource
	
	private static final DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")
	private static final DATE_FORMAT_DOWNLOAD = new SimpleDateFormat("dd-MM-yy")
	
	
	private static final String QUERY = """	
			 SELECT movement.date_created AS movement_date_created,
			 coalesce(movement_item.amount*movement_item.multiplier,0) AS movement_item_amount,
			 movement_item.date AS movement_item_date,
		     movement_item.date_created AS movement_item_date_created,
			 movement_item.description AS movement_item_description,
		     coalesce(movement_item.iibb*movement_item.multiplier,0) AS movement_item_iibb,
			 coalesce(movement_item.iva*movement_item.multiplier,0) AS movement_item_iva,
		     coalesce(movement_item.total*movement_item.multiplier,0) AS movement_item_total, 
			 movement.number AS movement_number,
		     CONCAT(upper(movement.type)," ",movement.number,"/",movement.year) AS operation,
		     movement.note AS movement_note, work.code AS work_code,
		     work.name AS work_name, concept.code AS concept_code,
			 supplier.name as supplier_name,

			 round(coalesce(movement_item.amount*movement_item.multiplier,0)*pii.index_value/
			 (select max(pii2.index_value) from price_index_item pii2 where index_id = :priceIndexId and
			 (pii2.date >=  :dateFrom or :dateFrom is null ) and (pii2.date < :dateTo or :dateTo is null)
			 )
			 ,2) amount_indexed,
			 round(coalesce(movement_item.iibb*movement_item.multiplier,0)*pii.index_value/
			 (select max(pii2.index_value) from price_index_item pii2 where index_id = :priceIndexId and
			 (pii2.date >=  :dateFrom or :dateFrom is null ) and (pii2.date < :dateTo or :dateTo is null)
			 )
			 ,2) iibb_indexed,
			  round(coalesce(movement_item.iva*movement_item.multiplier,0)*pii.index_value/
			 (select max(pii2.index_value) from price_index_item pii2 where index_id = :priceIndexId and
			 (pii2.date >=  :dateFrom or :dateFrom is null ) and (pii2.date < :dateTo or :dateTo is null)
			 )
			 ,2) iva_indexed,
			  round(coalesce(movement_item.total*movement_item.multiplier,0)*pii.index_value/
			 (select max(pii2.index_value) from price_index_item pii2 where index_id = :priceIndexId and
			 (pii2.date >=  :dateFrom or :dateFrom is null ) and (pii2.date < :dateTo or :dateTo is null)
			 )
			 ,2) total_indexed
		FROM
		     movement movement INNER JOIN movement_item movement_item ON movement.id = movement_item.movement_id
		     left JOIN work work ON movement_item.work_id = work.id
		     INNER JOIN concept concept ON movement_item.concept_id = concept.id
		     left JOIN supplier supplier ON movement_item.supplier_id = supplier.id
		LEFT OUTER JOIN concept_group cg ON concept.concept_group_id = cg.id
		
		left outer join price_index pi on pi.id = :priceIndexId
		left outer join price_index_item pii on pii.index_id = pi.id 
		and case when pi.frequency = 'daily' then DATE_FORMAT(movement_item.date, '%Y-%m-%d') = DATE_FORMAT(pii.date, '%Y-%m-%d')
		else DATE_FORMAT(movement_item.date, '%Y-%m-01') = DATE_FORMAT(pii.date, '%Y-%m-01') end

		where (movement_item.date >=  :dateFrom or :dateFrom is null ) and (movement_item.date < :dateTo or :dateTo is null)
		and ((:workId = -2 and work.id is not null) or  (:workId > -1 and work.id = :workId) or (:workId = -1 and work.id is null)
		and (:concepts = 'all' or 
		(:concepts = 'toM799' and (concept.code between 'M000' and 'M799' or concept.code between 'P000' and 'P799')) 
	or (:concepts = 'fromM800'and (concept.code between 'M800' and 'M999' or concept.code between 'P800' and 'P999'))
		))
		ORDER BY work.code ASC, cg.name asc, concept.code asc, movement.date_created desc
	"""
	
    def index() { }
	
	def downloadExcel(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='Ingresos y egresos.xlsx'");
		
		new WebXlsxExporter().with {
			fillHeader(["Obra","Operación","Proveedor","Cuenta","Fecha","Descripción","Monto \$","IVA \$", "IIBB","Monto indexado","IVA indexado","IIBB indexado","Total indexado"])
			
			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			
			Sql sql = new Sql(dataSource)
			def rows = sql.rows(QUERY,[priceIndexId:params.long('Price_index_id'),concepts:params.concepts,workId:params.long('Work_id'),dateFrom:params.Date_from?DATE_FORMAT.parse(params.Date_from):null,dateTo:params.Date_to?DATE_FORMAT.parse(params.Date_to):null])
			long queryCount = rows.size()
			add(rows, ["work_code","operation","supplier_name","concept_code","movement_date_created","movement_item_description","movement_item_amount","movement_item_iva","movement_item_iibb","amount_indexed","iibb_indexed","iva_indexed","total_indexed"])
			sql.close()
			
			
			for(int i = 1;i <= queryCount; i++){
				getCellAt(i, 4).setCellStyle(cellStyle)
			}
			for(int i = 0;i < 13; i++){
				sheet.autoSizeColumn(i)
			}
			
			save(response.outputStream)
		}
	}
}
