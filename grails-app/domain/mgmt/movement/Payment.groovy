package mgmt.movement

import mgmt.account.Account

import org.grails.databinding.BindUsing

class Payment {

	Date dateCreated
	Date lastUpdated

	Account account
	@BindUsing({
		obj, source -> new BigDecimal(source['amount'])
	})
	BigDecimal amount
	Date paymentDate
	String checkNumber
	String note	
	int multiplier
	
	static belongsTo = [movement: Movement]

	static constraints = {
		note blank:true, nullable:true
		checkNumber blank:true, nullable:true
	}
	
	BigDecimal getSignedAmount(){
		return amount * multiplier
	}
	
}
