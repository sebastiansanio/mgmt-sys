package mgmt.account

import java.util.Date;

import pl.touk.excel.export.WebXlsxExporter
import mgmt.movement.Payment


class AccountTypeStatusController {
	
	private static final FIELDS = ["movement","account","signedAmount","paymentDate","checkNumber",
		"note","dateCreated","lastUpdated"]
	
    def index() { 
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'
        respond AccountType.list(params)
	}
	
    def show(AccountType accountTypeInstance) {
		if (accountTypeInstance == null) {
			notFound()
			return
		}
        respond accountTypeInstance
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
