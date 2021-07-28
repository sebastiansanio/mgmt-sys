package mgmt.balance
import groovy.sql.Sql
import java.text.SimpleDateFormat
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter

class PaymentsExportController {

	def dataSource

	private static final DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")
	private static final DATE_FORMAT_DOWNLOAD = new SimpleDateFormat("dd-MM-yy")


	private static final String QUERY = """	 select m.date_created, CONCAT(upper(m.type)," ",m.number,"/",m.year) AS operation, 
a.name account_name,p.check_number,m.note,p.note,p.payment_date,p.amount,
group_concat(concat(c.code , " ", c.description,": ",mi.total, " (",coalesce(mi.description,''),")") order by c.code separator ', ') as detail from movement m inner join payment  p on p.movement_id = m.id inner join account a on p.account_id = a.id inner join movement_item mi on mi.movement_id = m.id inner join concept c on mi.concept_id = c.id where m.type = 'op'  
and (m.date_created >=  :dateFrom or :dateFrom is null ) and (m.date_created < :dateTo or :dateTo is null)
group by m.date_created, CONCAT(upper(m.type)," ",m.number,"/",m.year) , a.name,p.check_number,m.note,p.note,p.payment_date,p.amount
				"""

    def index() { }

	def downloadExcel(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"Detalle de pagos.xlsx\"");

		new WebXlsxExporter().with {
			fillHeader(["Fecha","Operación","Cuenta","Nro cheque","Nota","Fecha de pago","Monto \$","Detalle"])

			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));

			Sql sql = new Sql(dataSource)
			def rows = sql.rows(QUERY,[dateFrom:params.Date_from?DATE_FORMAT.parse(params.Date_from):null,dateTo:params.Date_to?DATE_FORMAT.parse(params.Date_to):null])
			long queryCount = rows.size()
			add(rows, ["date_created","operation","account_name","check_number","note","payment_date","amount","detail"])
			sql.close()


			for(int i = 1;i <= queryCount; i++){
				getCellAt(i, 0).setCellStyle(cellStyle)
				getCellAt(i, 5).setCellStyle(cellStyle)
			}
			for(int i = 0;i < 7; i++){
				sheet.autoSizeColumn(i)
			}

			save(response.outputStream)
		}
	}
}
