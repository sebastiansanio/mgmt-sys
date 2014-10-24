package mgmt.payment

class InvoiceType {
	
	String code

    static constraints = {
		code unique:true
    }
	
	String toString(){
		return code
	}
}
