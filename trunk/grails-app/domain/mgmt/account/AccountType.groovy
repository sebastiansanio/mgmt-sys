package mgmt.account

import java.util.Date;

class AccountType {
	
	Date dateCreated
	Date lastUpdated

	String name
	
    static constraints = {
		name unique: true
    }
	
	String toString(){
		return name
	}
}
