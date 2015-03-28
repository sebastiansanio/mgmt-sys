package mgmt.work

import mgmt.concept.Concept
import mgmt.persons.Supplier

class SupplierBudget {

	Work work
	Supplier supplier
	Concept concept
	BigDecimal amount
	BigDecimal iva
	String note
	
	Date dateCreated
	Date lastUpdated
	
    static constraints = {
		note blank: true, nullable: true, maxSize: 4000
		
    }
}
