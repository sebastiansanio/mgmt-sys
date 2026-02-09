package mgmt.utils

import java.text.DateFormat
import java.text.SimpleDateFormat
import pl.touk.excel.export.getters.PropertyGetter

class DateGetter extends PropertyGetter<Date, String> {
	
	private static final DateFormat DATE_FORMAT = new SimpleDateFormat("dd-MM-yy")
	
	DateGetter(String propertyName) {
		super(propertyName)
	}

	@Override
	protected String format(Date value) {
		return DATE_FORMAT.format(value)
	}
}
