package mgmt.persons
import mgmt.work.Work
import mgmt.work.Budget

class Client {
	
	Date dateCreated
	Date lastUpdated
	
	String cuit
	String name
	String businessName
	String address
	String location
	String province
	String zipCode
	String note
	
	static hasMany = [works: Work, budgets: Budget]
	
    static constraints = {
		name unique: true
		businessName unique: true
		cuit unique: true
		address blank:true, nullable:true
		location blank:true, nullable:true
		province blank:true, nullable:true
		zipCode blank:true, nullable:true
		note blank:true, nullable:true
    }
	
	String toString(){
		return name
	}
}
