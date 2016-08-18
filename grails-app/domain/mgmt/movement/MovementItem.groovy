package mgmt.movement

import mgmt.concept.Concept
import mgmt.invoice.InvoiceType
import mgmt.persons.Supplier
import mgmt.products.UnitOfMeasurement
import mgmt.work.SupplierBudget
import mgmt.work.Work


import org.grails.databinding.BindUsing

class MovementItem {
	
	Date dateCreated
	Date lastUpdated
	
	Work work
	Supplier supplier
	Concept concept
	String description
	InvoiceType invoiceType
	String invoiceNumber
	Date date
	int multiplier
	UnitOfMeasurement unit
	SupplierBudget budget
	@BindUsing({
		obj, source -> new BigDecimal(source['quantity'])
	})
	BigDecimal quantity
	@BindUsing({
		obj, source -> new BigDecimal(source['unitPrice'])
	})
	BigDecimal unitPrice
	
	@BindUsing({
		obj, source -> new BigDecimal(source['amount'])
	})
	BigDecimal amount
	@BindUsing({
		obj, source -> new BigDecimal(source['iva'])
	})
	BigDecimal iva
	@BindUsing({
		obj, source -> new BigDecimal(source['iibb'])
	})
	BigDecimal iibb
	@BindUsing({
		obj, source -> new BigDecimal(source['otherPerceptions'])
	})
	BigDecimal otherPerceptions
	@BindUsing({
		obj, source -> new BigDecimal(source['total'])
	})
	BigDecimal total
	
	
	static belongsTo = [movement: Movement]
	
    static constraints = {
		work nullable:true
		description nullable:true,blank:true
		invoiceType nullable:true
		invoiceNumber nullable:true,blank:true
		iibb nullable: true, validator: {value, object ->
			if (object.movement.type in ['op','os'] && value == null){
				return ["default.null.message"]
			}
        }
		otherPerceptions nullable: true, validator: {value, object ->
			if (object.movement.type in ['op','os'] && value == null){
				return ["default.null.message"]
			}
        }
		iva nullable: true, validator: {value, object ->
			if (object.movement.type in ['op','os','in'] && value == null){
				return ["default.null.message"]
			}
		}
		supplier nullable: true, validator: {value, object ->
			if (object.movement.type in ['op','os'] && value == null){
				return ["default.null.message"]
			}
        }
		budget nullable: true
		unit nullable: true
		quantity nullable: true
		unitPrice nullable: true
    }
	
}
