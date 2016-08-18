package mgmt.movement
import mgmt.config.Parameter

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
	
	Date checkedDate

	static hasMany = [items: MovementItem, payments: Payment]

	static constraints = {
		type inList: ['op', 'os', 'in', 'tr', 'fi']
		number unique: ['type','year'], nullable: false
		year nullable: false, min: 1900, max:9999
		items validator: {value, object ->
			if (object.type in ['op','os','in','fi'] && !value){
				return ["default.invalid.min.size.message",1]
			}
			if (object.type in ['op','os','in'] && !(object.calculateItemsTotal() == object.calculatePaymentsTotal())){
				return ["movement.amountsNotEqual.error"]
			}
			if (object.type in ['op','os']){
				for(MovementItem movementItem: object.items){
					if(movementItem.budget && movementItem.budget.realExpendures.remainingAmount < (movementItem.budget.movementItems.contains(movementItem)?0 :movementItem.amount) ){
						return ['supplierBudget.amountNotValid.error']
					}
					if(movementItem.budget && movementItem.budget.realExpendures.remainingIva < (movementItem.budget.movementItems.contains(movementItem)?0 :movementItem.iva) ){
						return ['supplierBudget.ivaNotValid.error']
					}
				}
				
			}
        }
		checkedDate nullable: true
		payments validator: {value, object ->
			if (object.type in ['op','os','in','tr'] && !value){
				return ["default.invalid.min.size.message",1]
			}
        }
		note nullable: true, blank: true, maxSize: 4000
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
		if(checked && !checkedDate){
			checkedDate = new Date()
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
	
	BigDecimal getAmount(){
		if(type in ['op','os','in']){
			return calculateItemsTotal()
		} else if (type == 'tr'){
			return payments[0].amount	
		} else if (type == 'fi'){
			BigDecimal calculatedAmount = BigDecimal.valueOf(0)
			for(MovementItem item in items){
				if(item.multiplier == 1){
					calculatedAmount += item.total
				}
			}
			return calculatedAmount
		}
	}
	
	String toString(){
		return type.toUpperCase() + " " + number + "/" + (year-2000)
	}
}
