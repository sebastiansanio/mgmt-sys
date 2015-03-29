package mgmt.work

import mgmt.concept.Concept
import mgmt.persons.Supplier

import org.grails.databinding.BindUsing

class SupplierBudget {

	Work work
	Supplier supplier
	Concept concept
	@BindUsing({
		obj, source -> new BigDecimal(source['amount'])
	})
	BigDecimal amount
	@BindUsing({
		obj, source -> new BigDecimal(source['iva'])
	})
	BigDecimal iva
	String note
	
	Date dateCreated
	Date lastUpdated
	
    static constraints = {
		note blank: true, nullable: true, maxSize: 4000
		
    }
}
