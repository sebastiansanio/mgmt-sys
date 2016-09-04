package mgmt.work

import java.util.Date;

import mgmt.movement.MovementItem
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
	
	
	static hasMany = [movements: MovementItem]
	
    static constraints = {
		client nullable: true
		type inList: ["building","asset"]
		budget nullable: true, unique: true, validator: {value, object ->
			if (object.type == "building" && !value){
				return ["work.budget.null.message",1]
			}

		}
		code nullable:false, unique: 'type'
    }
	
	String toString(){
		return code + " - " + name
	}
	
	String getCodeAndName(){
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
