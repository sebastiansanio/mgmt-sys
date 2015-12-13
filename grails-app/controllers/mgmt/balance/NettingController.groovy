package mgmt.balance

import groovy.sql.Sql

class NettingController {

	
	def dataSource
	
    def index() {
		Map results = new HashMap()
		def sql = new Sql(dataSource)
		def row = sql.firstRow("select sum(amount+iibb+other_perceptions) as amount,sum(iva) as iva from movement_item where concept_id in (select id from concept where code between 'P800' and 'P810')")
		results.incomeAmount = row.amount
		results.incomeIva = row.iva
		sql.close()
		
		row = sql.firstRow("select sum(amount+iibb+other_perceptions) as amount,sum(iva) as iva from movement_item where concept_id in (select id from concept where code between 'M800' and 'M810')")
		results.expensesAmount = row.amount
		results.expensesIva = row.iva
		sql.close()
		
		[results: results]
		
	}
}
