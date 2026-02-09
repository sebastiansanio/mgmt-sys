package mgmt.concept

import grails.gorm.transactions.Transactional
import mgmt.movement.MovementItem
import mgmt.work.BudgetItem
import mgmt.work.SupplierBudget

class ConceptMigrationController {

	def index() {
		[:]
	}
	
	@Transactional
	def migrate(){
		Concept conceptFrom = Concept.get(params.long('conceptFrom'))
		Concept conceptTo = Concept.get(params.long('conceptTo'))
		
		MovementItem.executeUpdate("update MovementItem mi set mi.concept = :conceptTo where mi.concept=:conceptFrom",
			[conceptTo: conceptTo, conceptFrom:conceptFrom])
		SupplierBudget.executeUpdate("update SupplierBudget mi set mi.concept = :conceptTo where mi.concept=:conceptFrom",
			[conceptTo: conceptTo, conceptFrom:conceptFrom])
		BudgetItem.executeUpdate("update BudgetItem mi set mi.concept = :conceptTo where mi.concept=:conceptFrom",
			[conceptTo: conceptTo, conceptFrom:conceptFrom])

		flash.message = message(code: 'conceptMigration.success.message',args: [conceptFrom.toString(),conceptTo.toString()])
		redirect action: "index"
	}
}
