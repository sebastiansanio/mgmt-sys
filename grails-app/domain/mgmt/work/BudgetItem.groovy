package mgmt.work

import mgmt.concept.Concept

class BudgetItem {

	Concept concept
	BigDecimal amount
	
	static belongsTo = [budget: Budget]
	
    static constraints = {
    }
}
