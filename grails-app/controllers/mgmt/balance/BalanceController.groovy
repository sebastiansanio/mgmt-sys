package mgmt.balance

import groovy.sql.Sql
import mgmt.work.Work

class BalanceController {

	def dataSource
	
    def index() { 
		
	}
	
	def show(){
		Work work = Work.get(params.long('workId'))
		Map amounts = new HashMap()
		amounts.income = calculateAmount(work.id,'P100','P101')
		amounts.otherIncome = calculateAmount(work.id,'P200','P600')
		amounts.directCosts = calculateAmount(work.id,'A000','K999')
		amounts.generalExpenses = calculateAmount(work.id,'L000','L899')
		amounts.retiredBenefits = calculateAmount(work.id,'N000','N999')
		amounts.sellPrice = [amount: amounts.income.amount + amounts.otherIncome.amount, iva: amounts.income.iva + amounts.otherIncome.iva]
		amounts.indirectGeneralExpenses =  work.budget? (work.budget.indirectOverheadPercentage? amounts.income.amount * work.budget.indirectOverheadPercentage/100 :  work.budget.indirectOverheadAmount):0
		
		amounts.totalGeneralExpenses = [amount: amounts.generalExpenses.amount + amounts.indirectGeneralExpenses, iva: amounts.generalExpenses.iva]
		amounts.totalExpenses = [amount: amounts.generalExpenses.amount + amounts.indirectGeneralExpenses + amounts.directCosts.amount, iva: amounts.generalExpenses.iva + amounts.directCosts.iva]

		amounts.calculatedBenefits = [amount: amounts.sellPrice.amount - amounts.totalExpenses.amount, iva: amounts.sellPrice.iva - amounts.totalExpenses.iva]
		
		[work: work, amounts: amounts]
		
	}
	
	private Map calculateAmount(long workId, String conceptFrom, String conceptTo){
		def sql = new Sql(dataSource)
		def row = sql.firstRow("select coalesce(sum(amount + iibb + other_perceptions),0) as amount, coalesce(sum(iva),0) as iva from movement_item mi inner join concept c on mi.concept_id = c.id where mi.work_id = ? and c.code between ? and ?",workId,conceptFrom,conceptTo)
		Map results = new HashMap()
		results.amount = row.amount
		results.iva = row.iva
		sql.close()
		return results
	}
	
	def download(){
		redirect(controller: 'report', action: 'downloadReport', params: [workId:params.workId, id: params.id])
	}
}
