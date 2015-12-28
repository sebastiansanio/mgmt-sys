package mgmt.work

import mgmt.concept.Concept
import mgmt.movement.MovementItem
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
	
	Date date
	
	Integer code
	
    static constraints = {
		note blank: true, nullable: true, maxSize: 4000
		date nullable: true
		code nullable: true
    }
	
	Map getRealExpendures(){
		Map calculatedRealExpendures = new HashMap()
		def results = MovementItem.createCriteria().get {
			eq("work", work)
			eq("supplier", supplier)
			eq("concept", concept)
			
			projections {
				sum 'amount'
				sum 'iva'
			}
		}
		calculatedRealExpendures.expendedAmount = results[0]?:0
		calculatedRealExpendures.expendedIva = results[1]?:0
		calculatedRealExpendures.remainingAmount = amount - calculatedRealExpendures.expendedAmount
		calculatedRealExpendures.remainingIva = iva - calculatedRealExpendures.expendedIva
		
		return calculatedRealExpendures
		
	}
	
}
