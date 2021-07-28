package mgmt.account

import groovy.sql.Sql
import java.text.SimpleDateFormat
import java.util.Date;

import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter
import mgmt.movement.Payment
import mgmt.utils.DateGetter


class AccountTypeStatusController {

	def dataSource
	private static final DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")
	private static final DATE_FORMAT_DOWNLOAD = new SimpleDateFormat("dd-MM-yy")


	private static final FIELDS = ["account","movement","movement.dateCreated","paymentDate",
		"signedAmount","checkNumber","note","movement.lastUpdated"]

    def index() {
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'

		Map balances = new HashMap()
		Sql sql = new Sql(dataSource)
		def rows = sql.rows("select a.type_id as typeId,sum(p.amount*p.multiplier) as amount from payment p inner join account a on p.account_id = a.id where payment_date <= now() group by a.type_id")
		rows.each { row ->
			balances[row.typeId] = row.amount
		}
		sql.close()

        respond AccountType.list(params), model: [balances:balances]
	}

    def show() {
		AccountType accountTypeInstance = AccountType.get(params.long('id'))
		params.balanceDate = params.balanceDate? DATE_FORMAT.parse(params.balanceDate): new Date()
		Map balances = new HashMap()
		Sql sql = new Sql(dataSource)
		def rows = sql.rows("select p.account_id as accountId,sum(p.amount*p.multiplier) as amount from payment p where payment_date <= ? group by p.account_id",params.balanceDate)
		rows.each { row ->
			balances[row.accountId] = row.amount
		}
		sql.close()

		def accounts


		if (accountTypeInstance){
			accounts = accountTypeInstance.accounts.findAll{balances[it.id]}.sort{((balances[it.id]?:0) !=0 ? ' ':'') +    it.name}
		}else{
			accounts = Account.list().findAll{!balances[it.id]}.sort{it.name}
		}

        respond accounts,model: [accounts:accounts,balances:balances]
    }

	def showPayments(Account account){
		params.max = 100
		params.sort = 'paymentDate'
		params.order = 'desc'

		def payments = Payment.createCriteria().list (params) {
			eq("account", account)
			if(params.dateFrom){
				ge("paymentDate", DATE_FORMAT.parse(params.dateFrom))
			}
			if(params.dateTo){
				le("paymentDate", DATE_FORMAT.parse(params.dateTo))
			}
			order(params.sort, params.order)
		}

		render model: [payments: payments,account:account,paymentsCount: payments.totalCount], view: 'showPayments'
	}

	def download(Account account){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"${message(code:'payments.label')}.xlsx\"");
		params.sort = 'paymentDate'
		params.order = 'desc'

		def headers = FIELDS.collect{
			message(code:'payment.report.'+it+'.label')
		}

		def payments = Payment.createCriteria().list () {
			eq("account", account)
			if(params.dateFrom){
				ge("paymentDate", DATE_FORMAT.parse(params.dateFrom))
			}
			if(params.dateTo){
				le("paymentDate", DATE_FORMAT.parse(params.dateTo))
			}
			order(params.sort, params.order)
		}


		new WebXlsxExporter().with {
			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));

			fillHeader(headers)

			def balance = 0
			if(params.dateFrom){
				Date balanceDate = DATE_FORMAT.parse(params.dateFrom).plus(-1)
				Sql sql = new Sql(dataSource)
				def rows = sql.rows("select sum(p.amount*p.multiplier) as amount from payment p where payment_date <= ? and p.account_id = ?",balanceDate,account.id)
				rows.each { row ->
					balance = row.amount
				}
				sql.close()

				fillRow(["", "SALDO AL "+DATE_FORMAT_DOWNLOAD.format(balanceDate) ,"","", balance], 1)
			}
			fillRow(["", "SALDO DEL PERIODO","","", balance + payments.sum{it.signedAmount} ], 2)
			add(payments, FIELDS,3)

			for(int i = 3;i <= payments.size()+2; i++){
				getCellAt(i, 2).setCellStyle(cellStyle)
				getCellAt(i, 3).setCellStyle(cellStyle)
				getCellAt(i, 7).setCellStyle(cellStyle)
			}
			for(int i = 0;i < FIELDS.size(); i++){
				sheet.autoSizeColumn(i)
			}
			save(response.outputStream)
		}
	}
}
