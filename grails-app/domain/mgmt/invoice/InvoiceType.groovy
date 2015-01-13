package mgmt.invoice

class InvoiceType {
	
	Date dateCreated
	Date lastUpdated
	
	String code

    static constraints = {
		code unique:true
    }
	
	String toString(){
		return code
	}
}
