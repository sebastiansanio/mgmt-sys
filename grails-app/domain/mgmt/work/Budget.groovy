package mgmt.work

import mgmt.persons.Client

import org.grails.databinding.BindUsing

class Budget {
	
	Date dateCreated
	Date lastUpdated
	
	Client client
	String name
	@BindUsing({
		obj, source -> new BigDecimal(source['directCosts'])
	})
	BigDecimal directCosts
	@BindUsing({
		obj, source -> new BigDecimal(source['iibbPercentage'])
	})
	BigDecimal iibbPercentage
	@BindUsing({
		obj, source -> new BigDecimal(source['iibbAmount'])
	})
	BigDecimal iibbAmount
	@BindUsing({
		obj, source -> new BigDecimal(source['indirectOverheadPercentage'])
	})
	BigDecimal indirectOverheadPercentage
	@BindUsing({
		obj, source -> new BigDecimal(source['indirectOverheadAmount'])
	})
	BigDecimal indirectOverheadAmount
	@BindUsing({
		obj, source -> new BigDecimal(source['profitPercentage'])
	})
	BigDecimal profitPercentage
	@BindUsing({
		obj, source -> new BigDecimal(source['profitAmount'])
	})
	BigDecimal profitAmount
	@BindUsing({
		obj, source -> new BigDecimal(source['ivaPercentage'])
	})
	BigDecimal ivaPercentage

	@BindUsing({
		obj, source -> new BigDecimal(source['totalAmount'])
	})
	BigDecimal totalAmount
	boolean hasWork

	
	List items = new ArrayList()

	static hasMany = [items: BudgetItem]

    static constraints = {
		client nullable: true
    }
	
	String toString(){
		return name
	}
	
	BigDecimal getTotalAmountWithIva(){
		return totalAmount * (1+ ivaPercentage/100)
	}
}
