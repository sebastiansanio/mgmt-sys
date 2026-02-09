package mgmt.work

import mgmt.concept.Concept

import grails.databinding.BindUsing

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
