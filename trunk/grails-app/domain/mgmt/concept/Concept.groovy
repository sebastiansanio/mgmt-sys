package mgmt.concept

import java.util.Date;

class Concept {
	
	Date dateCreated
	Date lastUpdated
	
	ConceptAccount conceptAccount
	ConceptGroup conceptGroup
	String code
	String description
	
	boolean validInFiWork
	boolean validInTrWork
	boolean validInOpWork
	boolean validInOsWork
	boolean validInInWork
	boolean validInFiNoWork
	boolean validInTrNoWork
	boolean validInOpNoWork
	boolean validInOsNoWork
	boolean validInInNoWork

	
    static constraints = {
		code unique:true
    }
	
	String toString(){
		return code
	}
	
}
