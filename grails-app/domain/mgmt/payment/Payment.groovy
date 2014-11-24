package mgmt.payment

import mgmt.core.Account

class Payment {

	Account account
	BigDecimal amount
	Date paymentDate
	String checkNumber 
	String note
	
	static belongsTo = [paymentOrder: PaymentOrder]
	
    static constraints = {
    }
}
