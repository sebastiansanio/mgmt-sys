package mgmt.payment


class PaymentOrder {

	Date dateCreated
	Date lastUpdated

	String type
	long number
	Date date
	List items
	List invoices
	List payments
	boolean checked

	static hasMany = [items: PaymentOrderItem, payments: Payment]

	static constraints = {
		type inList: ['op', 'os']
		number unique: 'type'
	}
}
