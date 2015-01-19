package mgmt.movement

import mgmt.concept.Concept
import mgmt.invoice.InvoiceType
import mgmt.persons.Supplier
import mgmt.work.Work

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
	
	BigDecimal amount
	BigDecimal iva
	BigDecimal iibb
	BigDecimal total
	BigDecimal otherPerceptions
	
	static belongsTo = [movement: Movement]
	
    static constraints = {
		work nullable:true
		description nullable:true,blank:true
		invoiceNumber nullable:true,blank:true
    }
	
}
