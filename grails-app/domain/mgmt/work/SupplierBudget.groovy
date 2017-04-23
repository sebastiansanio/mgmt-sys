package mgmt.work

import java.util.List;

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
	List items = new ArrayList()
	
	Date dateCreated
	Date lastUpdated
	boolean closed
	Date date
	
	static hasMany = [movementItems: MovementItem,items:SupplierBudgetItem]
	
    static constraints = {
		work nullable: true
		note blank: true, nullable: true, maxSize: 4000
		date nullable: true
		invoiceType nullable: true
		amount validator: {value, object ->
			if (object.totalAmount < object.realExpendures.expendedAmount){
				return ["supplierBudget.amountNotValid.error"]
			}
        }
		iva validator: {value, object ->
			if (object.totalIva < object.realExpendures.expendedIva){
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
		calculatedRealExpendures.remainingAmount = totalAmount.minus(calculatedRealExpendures.expendedAmount)
		calculatedRealExpendures.remainingIva = totalIva.minus(calculatedRealExpendures.expendedIva)
				
		return calculatedRealExpendures
	}
	
	BigDecimal getExtrasAmount(){
		BigDecimal totalAmount = BigDecimal.valueOf(0)
		for(SupplierBudgetItem item in items){
			totalAmount += item.amount
		}
		return totalAmount
	}
	
	BigDecimal getExtrasIva(){
		BigDecimal totalIva = BigDecimal.valueOf(0)
		for(SupplierBudgetItem item in items){
			totalIva += item.iva
		}
		return totalIva
	}
	
	BigDecimal getTotalAmount(){
		return getExtrasAmount()+amount
	}
	
	BigDecimal getTotalIva(){
		return getExtrasIva()+iva
	}
	
	String getIdAndRemainingAmount(){
		return id.toString() + " (" + getRealExpendures().remainingAmount + ")"
	}
	
}
