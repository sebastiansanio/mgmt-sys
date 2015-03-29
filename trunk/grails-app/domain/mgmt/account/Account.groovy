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
}
