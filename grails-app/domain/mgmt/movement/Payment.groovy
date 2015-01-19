package mgmt.movement

import mgmt.account.Account

class Payment {

	Date dateCreated
	Date lastUpdated

	Account account
	BigDecimal amount
	Date paymentDate
	String checkNumber
	String note
	
	static belongsTo = [movement: Movement]

	static constraints = {
		note blank:true, nullable:true
		checkNumber blank:true, nullable:true
	}
}
