package mgmt.payment

import mgmt.core.Work

class PaymentOrderItem {

	static belongsTo = [paymentOrder: PaymentOrder]
	
    static constraints = {
		
    }
	
}
