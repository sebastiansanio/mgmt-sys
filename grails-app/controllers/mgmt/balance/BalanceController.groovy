package mgmt.balance

import groovy.sql.Sql
import mgmt.work.Work
import mgmt.index.PriceIndex

class BalanceController {

	
	private static final String QUERY = """
		select 
		coalesce(sum(case when :priceIndexId = -1 then amount + iibb + other_perceptions else (amount + iibb + other_perceptions) /pii.index_value *(case when pi.id <> 3 then pii_max.index_value else 1 end) end),0) as amount, 
		coalesce(sum(case when :priceIndexId = -1 then iva else iva /pii.index_value *(case when pi.id <> 3 then pii_max.index_value else 1 end) end),0) as iva 

		from movement_item mi 
		inner join concept c on mi.concept_id = c.id 
		left outer join price_index pi on pi.id = :priceIndexId
		left outer join price_index_item pii_max on pii_max.index_id = pi.id and pii_max.date = (select max(pii3.date) from price_index_item pii3 where pii3.index_id = pi.id)
		left outer join price_index_item pii on pii.index_id = pi.id 
		and case when pi.frequency = 'daily' then DATE_FORMAT(mi.date, '%Y-%m-%d') = DATE_FORMAT(pii.date, '%Y-%m-%d')
		when pi.frequency = 'monthly' then DATE_FORMAT(date_add(mi.date,interval -1 month), '%Y-%m-01') = DATE_FORMAT(pii.date, '%Y-%m-01')
		else DATE_FORMAT(mi.date, '%Y-%m-01') = DATE_FORMAT(pii.date, '%Y-%m-01') end

		where mi.work_id = :workId and c.code between :conceptFrom and :conceptTo
	"""
	
	def dataSource
	
    def index() { 
		
	}
	
	def show(){
		Work work = Work.get(params.long('workId'))
		long priceIndexId = params.long('Price_index_id')
		Map amounts = new HashMap()
		amounts.income = calculateAmount(work.id,'P100','P101',priceIndexId)
		amounts.otherIncome = calculateAmount(work.id,'P200','P600',priceIndexId)
		amounts.directCosts = calculateAmount(work.id,'A000','I999',priceIndexId)
		amounts.generalExpenses = calculateAmount(work.id,'L000','L899',priceIndexId)
		amounts.retiredBenefits = calculateAmount(work.id,'N000','N999',priceIndexId)
		amounts.sellPrice = [amount: amounts.income.amount + amounts.otherIncome.amount, iva: amounts.income.iva + amounts.otherIncome.iva]
		amounts.indirectGeneralExpenses =  work.budget? (work.budget.indirectOverheadPercentage? amounts.income.amount * work.budget.indirectOverheadPercentage/100 :  work.budget.indirectOverheadAmount):0
		
		amounts.totalGeneralExpenses = [amount: amounts.generalExpenses.amount + amounts.indirectGeneralExpenses, iva: amounts.generalExpenses.iva]
		amounts.totalExpenses = [amount: amounts.generalExpenses.amount + amounts.indirectGeneralExpenses + amounts.directCosts.amount, iva: amounts.generalExpenses.iva + amounts.directCosts.iva]

		amounts.calculatedBenefits = [amount: amounts.sellPrice.amount - amounts.totalExpenses.amount, iva: amounts.sellPrice.iva - amounts.totalExpenses.iva]
		
		[work: work, amounts: amounts]
		
	}
	
	private Map calculateAmount(long workId, String conceptFrom, String conceptTo, long priceIndexId){
		def sql = new Sql(dataSource)
		def row = sql.firstRow(QUERY,[workId: workId,conceptFrom: conceptFrom,conceptTo: conceptTo,priceIndexId: priceIndexId ])
		Map results = new HashMap()
		results.amount = row.amount
		results.iva = row.iva
		sql.close()
		return results
	}
	
	def download(){
		redirect(controller: 'report', action: 'downloadReport', params: [workId:params.workId, Price_index_id:params.Price_index_id, id: params.id])
	}
}
