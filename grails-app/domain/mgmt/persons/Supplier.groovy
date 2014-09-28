package mgmt.persons

import java.util.Date;

class Supplier {
	Date dateCreated
	Date lastUpdated
	
	String name
	String address
	String location
	String province
	String zipCode
	String note
	
    static constraints = {
		name unique:true
    }
	
	String toString(){
		return name
	}
}
