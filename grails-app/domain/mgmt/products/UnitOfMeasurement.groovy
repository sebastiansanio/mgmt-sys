package mgmt.products

import java.util.Date;

class UnitOfMeasurement {

	Date dateCreated
	Date lastUpdated

	String name
	
	static constraints = {
		name unique: true
	}
	
	String toString(){
		return name
	}
}
