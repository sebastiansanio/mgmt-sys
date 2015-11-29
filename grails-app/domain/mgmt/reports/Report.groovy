package mgmt.reports

class Report {

	Date dateCreated
	Date lastUpdated
	
	String name
	String code
	byte[] definition
	String variables
	
    static constraints = {
		definition maxSize: 4000000
		variables maxSize: 4000, blank: true, nullable: true
		code unique: true, blank: false, nullable: false
    }
	
	List variablesAsList(){
		List variablesListAux = new ArrayList()
		List variablesList = new ArrayList()
		if(variables){
			variablesListAux = variables.split(";")
			for(variable in variablesListAux){
				List variableComponents = variable.split(":")
				variablesList.add([variable: variableComponents[0].trim(), type: variableComponents[1].trim(), jasperVariable: variableComponents[2].trim() ])
			}
		}
		return variablesList
	}
}
