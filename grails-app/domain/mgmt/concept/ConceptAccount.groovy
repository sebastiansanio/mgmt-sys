package mgmt.concept

import java.util.Date;

class ConceptAccount {

	Date dateCreated
	Date lastUpdated
	
	String name
	
    static constraints = {
		name unique:true
    }
	
	String toString(){
		return name
	}
}
