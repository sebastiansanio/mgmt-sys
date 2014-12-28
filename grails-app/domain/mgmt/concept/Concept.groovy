package mgmt.concept

import java.util.Date;

class Concept {
	
	Date dateCreated
	Date lastUpdated
	
	ConceptAccount conceptAccount
	ConceptGroup conceptGroup
	String code
	String description
	
	
    static constraints = {
		code unique:true
    }
	
	String toString(){
		return code
	}
	
}
