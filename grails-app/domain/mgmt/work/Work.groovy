package mgmt.work

import mgmt.persons.Client

class Work {
	
	Date dateCrated
	Date lastUpdated

	Client client
	String name
	boolean finished
	String type
	long code
	Budget budget
	
    static constraints = {
		client nullable: true
		name unique: true
		type inList: ["building","asset"]
		budget nullable: true
    }
	
	String toString(){
		return name
	}
}
