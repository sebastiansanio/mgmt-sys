package mgmt.movement

class Movement {

	Date dateCreated
	Date lastUpdated

	String type
	long number
	Date date
	List items
	List payments
	boolean checked

	static hasMany = [items: MovementItem, payments: Payment]

	static constraints = {
		type inList: ['op', 'os', 'in', 'tr', 'fi']
		number unique: 'type'
	}

	def beforeValidate() {
		if(this.number == 0){
			Long number = Movement.createCriteria().get {
				projections { max "number" }
				eq("type", type)
			} as Long
			if(number == null){
				this.number = 1
			}else{
				this.number = number + 1
			}
		}
	}
}
