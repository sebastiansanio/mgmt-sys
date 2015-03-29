package mgmt.work

import mgmt.concept.Concept

import org.grails.databinding.BindUsing

class BudgetItem {

	Concept concept
	@BindUsing({
		obj, source -> new BigDecimal(source['amount'])
	})
	BigDecimal amount
	
	static belongsTo = [budget: Budget]
	
    static constraints = {
    }
}
