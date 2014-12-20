package mgmt.concept

class Concept {
	
	ConceptAccount conceptAccount
	ConceptGroup conceptGroup
	String code
	String description
	
	
    static constraints = {
    }
	
	String toString(){
		return code
	}
	
}
