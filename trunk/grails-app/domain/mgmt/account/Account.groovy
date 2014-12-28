package mgmt.account

import java.util.Date;

class Account {
	
	Date dateCreated
	Date lastUpdated
	
	String name
	String code
	AccountType type
	BigDecimal balance

    static constraints = {
    }
}
