package mgmt.account

import groovy.sql.Sql
import java.text.SimpleDateFormat
import java.util.Date;

import pl.touk.excel.export.WebXlsxExporter
import mgmt.movement.Payment


class AccountTypeStatusController {
	
	def dataSource
	private static final DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")
	
	private static final FIELDS = ["movement","account","signedAmount","paymentDate","checkNumber",
		"note","dateCreated","lastUpdated"]
	
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
	
    def show(AccountType accountTypeInstance) {
		params.dateTo = params.dateTo? DATE_FORMAT.parse(params.dateTo): new Date()
		Map balances = new HashMap()
		Sql sql = new Sql(dataSource)
		def rows = sql.rows("select p.account_id as accountId,sum(p.amount*p.multiplier) as amount from payment p where payment_date <= ? group by p.account_id",params.dateTo)
		rows.each { row ->
			balances[row.accountId] = row.amount
		}
		sql.close()
		
        respond accountTypeInstance, model: [balances:balances]
    }
	
	def showPayments(Account account){
		params.max = 100
		params.sort = 'paymentDate'
		params.order = 'desc'
		def payments = Payment.findAllByAccount(account,params)
		render model: [payments: payments,account:account,paymentsCount: Payment.countByAccount(account)], view: 'showPayments'
	}
	
	def download(Account account){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'payments.label')}.xlsx'");
		
		def headers = FIELDS.collect{
			message(code:'payment.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(Payment.findAllByAccount(account,[sort:'dateCreated',order:'desc']), FIELDS)
			save(response.outputStream)
		}
	}
}
