package mgmt.index

class PriceIndex {

	Date dateCreated
	Date lastUpdated

	String name
	String description

	static hasMany = [items: PriceIndexItem]

	static constraints = { name unique: true }
	
	public String toString(){
		return name
	}
}
