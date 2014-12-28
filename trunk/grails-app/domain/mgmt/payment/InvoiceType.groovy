package mgmt.payment

import java.util.Date;

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
