package mgmt.procurement

import mgmt.persons.Supplier

class Invoice {

	Date dateCreated
	Date lastUpdated
	long number
	String description	
	Supplier supplier
	
    static constraints = {
		number unique: 'supplier'
    }
}
