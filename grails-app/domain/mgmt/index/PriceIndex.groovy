package mgmt.index

class PriceIndex {

	Date dateCreated
	Date lastUpdated

	String name
	String description
	String frequency
	
	static hasMany = [items: PriceIndexItem]

	static constraints = { 
		name unique: true 
		description nullable:false, blank:false
		frequency inList: ["monthly","daily"], nullable: false, blank: false
	}
	
	public String toString(){
		return name
	}
}
