package mgmt.work

import mgmt.persons.Client

class Budget {
	
	Date dateCrated
	Date lastUpdated
	
	Client client
	String name
	BigDecimal directCosts
	BigDecimal iibbPercentage
	BigDecimal indirectOverheadPercentage
	BigDecimal profitPercentage
	BigDecimal ivaPercentage
	
	static hasMany = [items: BudgetItem]

    static constraints = {
		client nullable: true
    }
}
