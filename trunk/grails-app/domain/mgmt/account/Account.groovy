package mgmt.account

import mgmt.movement.Payment


class Account {
	
	Date dateCreated
	Date lastUpdated
	
	String name
	String code
	AccountType type
	boolean secured
	
	static hasMany = [payments: Payment]

    static constraints = {
		code unique: true
    }
	
	String toString(){
		return code + " - " + name
	}
	
	BigDecimal getCurrentBalance(){
		return getBalance(new Date().clearTime())
	}
	
	BigDecimal getBalance(Date date){
		BigDecimal calculatedBalance = BigDecimal.valueOf(0)
		for(payment in payments){
			if(payment.date <= date){
				calculatedBalance = calculatedBalance + (payment.amount * payment.multiplier)
			}
		}
		return calculatedBalance
	}
}
