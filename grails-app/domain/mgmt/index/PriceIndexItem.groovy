package mgmt.index

import org.grails.databinding.BindUsing

class PriceIndexItem {

	Date dateCreated
	Date lastUpdated

	Date date
	@BindUsing({
		obj, source -> new BigDecimal(source['indexValue'])
	})
	BigDecimal indexValue

	static belongsTo = [index: PriceIndex]

	static constraints = { date unique: 'index' 
							indexValue nullable: false
	}
}
