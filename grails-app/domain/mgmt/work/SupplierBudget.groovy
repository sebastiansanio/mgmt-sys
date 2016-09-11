package mgmt.work

import mgmt.concept.Concept
import mgmt.invoice.InvoiceType;
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
	InvoiceType invoiceType
	
	Date dateCreated
	Date lastUpdated
	boolean closed
	Date date
	
	static hasMany = [movementItems: MovementItem]
	
    static constraints = {
		work nullable: true
		note blank: true, nullable: true, maxSize: 4000
		date nullable: true
		invoiceType nullable: true
		amount validator: {value, object ->
			if (object.amount < object.realExpendures.expendedAmount){
				return ["supplierBudget.amountNotValid.error"]
			}
        }
		iva validator: {value, object ->
			if (object.iva < object.realExpendures.expendedIva){
				return ["supplierBudget.ivaNotValid.error"]
			}
        }
    }
	
	Map getRealExpendures(){
		Map calculatedRealExpendures = new HashMap()
		
		calculatedRealExpendures.expendedAmount = BigDecimal.valueOf(0)
		calculatedRealExpendures.expendedIva = BigDecimal.valueOf(0)
		
		for(MovementItem item: movementItems){
			calculatedRealExpendures.expendedAmount = calculatedRealExpendures.expendedAmount.plus(item.amount) 
			calculatedRealExpendures.expendedIva = calculatedRealExpendures.expendedIva.plus(item.iva)
		}
		calculatedRealExpendures.remainingAmount = amount.minus(calculatedRealExpendures.expendedAmount)
		calculatedRealExpendures.remainingIva = iva.minus(calculatedRealExpendures.expendedIva)
				
		return calculatedRealExpendures
	}
	
	String getIdAndRemainingAmount(){
		return id.toString() + " (" + getRealExpendures().remainingAmount + ")"
	}
	
}
