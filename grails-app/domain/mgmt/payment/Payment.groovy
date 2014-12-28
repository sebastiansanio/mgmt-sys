package mgmt.payment

import mgmt.account.Account

class Payment {

	Date dateCreated
	Date lastUpdated

	Account account
	BigDecimal amount
	Date paymentDate
	String checkNumber
	String note

	static belongsTo = [paymentOrder: PaymentOrder]

	static constraints = {
	}
}
