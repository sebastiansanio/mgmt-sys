package mgmt.account

import mgmt.movement.Payment


class Account {
	
	Date dateCreated
	Date lastUpdated
	
	String name
	String code
	AccountType type
	BigDecimal balance
	
	static hasMany = [payments: Payment]

    static constraints = {
		code unique: true
		name unique: true
    }
}
