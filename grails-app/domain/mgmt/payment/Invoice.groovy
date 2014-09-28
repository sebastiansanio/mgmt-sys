package mgmt.payment

import mgmt.core.Work
import mgmt.persons.Supplier

class Invoice {

	Date dateCreated
	Date lastUpdated
	
	Date date
	Work work
	Supplier supplier
	
	String type
	long number
		
    static constraints = {
		type inList: ['A','B','C','D','S/D']
	}
}
