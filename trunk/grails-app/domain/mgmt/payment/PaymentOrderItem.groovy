package mgmt.payment

import mgmt.concept.Concept
import mgmt.core.Work
import mgmt.persons.Supplier

class PaymentOrderItem {
	
	Work work
	Supplier supplier
	Concept concept
	String description
	InvoiceType invoiceType
	String invoiceNumber
	
	BigDecimal amount
	BigDecimal iva
	BigDecimal iibb
	BigDecimal total
	
	static belongsTo = [paymentOrder: PaymentOrder]
	
    static constraints = {
		description nullable:true,blank:true
		invoiceNumber nullable:true,blank:true
    }
	
}
