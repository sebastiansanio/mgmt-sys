package mgmt.core

class Work {

	String name
	boolean finished
	
    static constraints = {
		name unique: true
    }
}
