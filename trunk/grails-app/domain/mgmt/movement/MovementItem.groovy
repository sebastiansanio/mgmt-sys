package mgmt.movement

import mgmt.concept.Concept
import mgmt.invoice.InvoiceType
import mgmt.persons.Supplier
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
		invoiceNumber nullable:true,blank:true
    }
	
}
