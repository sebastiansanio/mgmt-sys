package mgmt.payment

import mgmt.core.Work
import mgmt.persons.Supplier

class Invoice {

	Date dateCreated
	Date lastUpdated
	
	Date date
	Work work
	Supplier supplier
		
	InvoiceType type
	long number
		
    static constraints = {
	}
}
