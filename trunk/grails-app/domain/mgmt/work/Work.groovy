package mgmt.work

import mgmt.persons.Client

class Work {
	
	Date dateCreated
	Date lastUpdated

	Client client
	String name
	boolean finished
	String type
	long code
	Budget budget
	
    static constraints = {
		client nullable: true
		type inList: ["building","asset"]
		budget nullable: true
    }
	
	String toString(){
		return code + " - " + name
	}
}
