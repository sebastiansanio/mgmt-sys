package mgmt.movement

class Movement {

	Date dateCreated
	Date lastUpdated

	String type
	Long number
	List items = new ArrayList()
	List payments = new ArrayList()
	boolean checked
	Integer year
	String note
	

	static hasMany = [items: MovementItem, payments: Payment]

	static constraints = {
		type inList: ['op', 'os', 'in', 'tr', 'fi']
		number unique: ['type','year'], nullable: false
		year nullable: false, min: 1900, max:9999
		items minSize: 1
		note nullable: true, blank: true, maxSize: 4000
		items validator: {value, object ->
			if (!(object.calculateItemsTotal() == object.calculatePaymentsTotal())){
				return ["movement.amountsNotEqual.error"]
			}
        }
	}

	static mapping = {
	}

	def beforeValidate() {
		if(!year){
			year = new Date()[Calendar.YEAR]
		}
		if(!number){
			Long calculatedNumber = Movement.createCriteria().get {
				projections { max "number" }
				eq("type", type)
				eq("year", year)
			} as Long
			if(!calculatedNumber){
				number = 1
			}else{
				number = calculatedNumber + 1
			}
		}
	}
	
	BigDecimal calculateItemsTotal(){
		BigDecimal itemsTotal = BigDecimal.valueOf(0)
		for(MovementItem item in items){
			itemsTotal += item.total
		}
		return itemsTotal
	}
	
	BigDecimal calculatePaymentsTotal(){
		BigDecimal paymentsTotal = BigDecimal.valueOf(0)
		for(Payment payment in payments){
			paymentsTotal += payment.amount
		}
		return paymentsTotal
	}
}
