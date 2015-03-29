package mgmt.work

import mgmt.persons.Client

class Work {
	
	Date dateCreated
	Date lastUpdated

	Client client
	String name
	boolean finished
	String type
	Long code
	Budget budget
	
    static constraints = {
		client nullable: true
		type inList: ["building","asset"]
		budget nullable: true
		code nullable:false, unique: 'type'
    }
	
	String toString(){
		return code + " - " + name
	}
	
	def beforeValidate() {
		if(!code){
			Long calculatedCode = Work.createCriteria().get {
				projections { max "code" }
				eq("type", type)
			} as Long
			if(!calculatedCode){
				code = 1
			}else{
				code = calculatedCode + 1
			}
		}
	}
}
