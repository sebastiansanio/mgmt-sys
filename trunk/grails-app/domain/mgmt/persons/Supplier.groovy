package mgmt.persons

import java.util.Date;

class Supplier {
	Date dateCreated
	Date lastUpdated
	String name
	String cuit
	
    static constraints = {
		name unique:true
		cuit unique:true
    }
	
	String toString(){
		return name
	}
}
