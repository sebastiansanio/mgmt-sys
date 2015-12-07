package mgmt.account

import groovy.sql.Sql
import java.util.Date;

class AccountType {
	
	Date dateCreated
	Date lastUpdated

	String name
	
	static hasMany = [accounts: Account]
	
    static constraints = {
		name unique: true
    }
	
	String toString(){
		return name
	}
	
	BigDecimal getCurrentBalance(){
		BigDecimal calculatedBalance = BigDecimal.valueOf(0)
		for(account in accounts){
			calculatedBalance = calculatedBalance + account.currentBalance
		}
		return calculatedBalance
		
	}
}
