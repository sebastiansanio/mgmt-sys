package mgmt.balance

import groovy.sql.Sql

class NettingController {

	
	def dataSource
	
    def index() {
		Map results = new HashMap()
		def sql = new Sql(dataSource)
		def row = sql.firstRow("select sum(coalesce(amount,0)+coalesce(iibb,0)+coalesce(other_perceptions,0)) as amount,sum(coalesce(iva,0)) as iva from movement_item where concept_id in (select id from concept where code between 'P800' and 'P810')")
		results.incomeAmount = row.amount
		results.incomeIva = row.iva
		sql.close()
		
		row = sql.firstRow("select sum(coalesce(amount,0)+coalesce(iibb,0)+coalesce(other_perceptions,0)) as amount,sum(coalesce(iva,0)) as iva from movement_item where concept_id in (select id from concept where code between 'M800' and 'M810')")
		results.expensesAmount = row.amount
		results.expensesIva = row.iva
		sql.close()
		
		[results: results]
		
	}
}
