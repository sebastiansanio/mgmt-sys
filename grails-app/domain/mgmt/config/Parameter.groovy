package mgmt.config

import java.text.DateFormat
import java.text.SimpleDateFormat

class Parameter {

	private static final DateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy")
	
	String code
	String value
	
    static constraints = {
		code unique: true, blank: false, nullable: false
		value blank: false, nullable: false
    }
	
	Date asDate(){
		return DATE_FORMAT.parse(value)
	}
	
}
