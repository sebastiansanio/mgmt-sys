package mgmt.payment

class InvoiceItem {

	String description
	BigDecimal amount
	BigDecimal iva
	BigDecimal iibb
	BigDecimal total
	
    static constraints = {
    }
}
