package mgmt.payment


class PaymentOrder {

	Date dateCreated
	Date lastUpdated

	String type
	long number
	Date date
	List items
	
	static hasMany = [items: PaymentOrderItem]

	static constraints = {
		type inList: ['op', 'os']
		number unique: 'type'
	}
}
