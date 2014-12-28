package mgmt.payment

import java.util.Date;

import mgmt.concept.Concept
import mgmt.persons.Supplier
import mgmt.work.Work;

class PaymentOrderItem {
	
	Date dateCreated
	Date lastUpdated
	
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
