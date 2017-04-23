package mgmt.work

import org.grails.databinding.BindUsing

class SupplierBudgetItem {

	static belongsTo = [budget: SupplierBudget]
	Date dateCreated
	Date lastUpdated
	@BindUsing({
		obj, source -> new BigDecimal(source['amount'])
	})
	BigDecimal amount
	@BindUsing({
		obj, source -> new BigDecimal(source['iva'])
	})
	BigDecimal iva
	String description
	
    static constraints = {
		amount nullable: false
		iva nullable: false
    }
}
