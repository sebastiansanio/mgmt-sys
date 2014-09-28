package mgmt.payment

import java.util.Date;

class PaymentOrder {

	Date dateCreated
	Date lastUpdated
	
	String type
	Date date
	long number
	
	
    static constraints = {
		type inList: ['op','os']
		number unique: 'type'
    }
}
