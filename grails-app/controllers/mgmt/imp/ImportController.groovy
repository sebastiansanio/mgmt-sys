package mgmt.imp

import grails.gorm.transactions.Transactional
import java.text.DateFormat
import java.text.SimpleDateFormat
import mgmt.account.Account
import mgmt.account.AccountType
import mgmt.concept.Concept
import mgmt.concept.ConceptAccount
import mgmt.concept.ConceptGroup
import mgmt.movement.Movement
import mgmt.movement.MovementItem
import mgmt.movement.Payment
import mgmt.persons.Client
import mgmt.persons.Supplier
import mgmt.work.Budget
import mgmt.work.BudgetItem
import mgmt.work.SupplierBudget
import mgmt.work.Work



class ImportController {

	private static final String delimiter = ";"
	private static final DateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
	private static final Map SUPPLIER_TRANSFORM = ["294":"149", "1494":"1493"]
	def index() {
	}

	@Transactional
	def importData(){
		def datatype = params.datatype
		def file = request.getFile('file')
		if (file.isEmpty()) {
			flash.error = 'El archivo no puede estar vacío'
			redirect(action:'index')
			return
		}
		if(datatype == "concepts"){

			file.inputStream.splitEachLine(delimiter) { fields ->
				
				def conceptAccount = ConceptAccount.findByName(fields[1].trim())
				if(!conceptAccount){
					conceptAccount = new ConceptAccount(name: fields[1].trim())
					conceptAccount.save(flush:true,failOnError:true)
				}
				def conceptGroup = ConceptGroup.findByName(fields[2].trim())
				if(!conceptGroup){
					conceptGroup = new ConceptGroup(name: fields[2].trim())
					conceptGroup.save(flush:true,failOnError:true)
				}
				new Concept(conceptAccount:conceptAccount,conceptGroup:conceptGroup,code:fields[3],description:fields[4],
						validInFiWork:fields[12]?true:false, validInOpWork:fields[7]?true:false, validInOsWork:fields[9]?true:false, 
						validInInWork:fields[11]?true:false,validInOpNoWork:fields[6]?true:false,validInOsNoWork:fields[8]?true:false, validInInNoWork:fields[10]?true:false).save(flush:true,failOnError:true)
			}
		} else if (datatype == "suppliers"){
			file.inputStream.splitEachLine(delimiter) { fields ->
				new Supplier(name:fields[1]?.trim(),businessName:fields[2]?.trim()?:fields[1]?.trim(),cuit:fields[3]?.trim()?:fields[0]?.trim()).save(failOnError:true)
				
			}
		} else if (datatype == "clients"){
			file.inputStream.splitEachLine(delimiter) { fields ->
				new Client(name:fields[1]?.trim(),businessName:fields[1]?.trim(),cuit:fields[3]?.trim()?:fields[0]?.trim()).save(failOnError:true)
				
			}
		} else if (datatype == "accounts"){
			file.inputStream.splitEachLine(delimiter) { fields ->
				def accountType = AccountType.findByName(fields[3].trim())
				if(!accountType){
					accountType = new AccountType(name: fields[3].trim())
					accountType.save(flush:true,failOnError:true)
				}
				new Account(type:accountType,code:fields[1],name:fields[2]).save(flush:true,failOnError:true)
			}
		} else if (datatype == "works"){ 
			file.inputStream.splitEachLine(delimiter) { fields ->
				boolean hasWork = ! (fields[4].isEmpty() || fields[4] == "0") 
				Date date = DATE_FORMAT.parse(fields[6].replaceAll("/([0-9]{2}) ", "/20\$1 ").replaceAll("\"",""))
				
				Budget budget = new Budget(oldCode: fields[2].toLong(),date: date,client: Client.findByCuit(fields[1]),name:fields[5]?.trim()?.replace("\"", ""),directCosts: fields[18]?new BigDecimal(fields[18].replace("+","").replace(",",".")):BigDecimal.valueOf(0),iibbPercentage: fields[14]?new BigDecimal(fields[14].replace("+","").replace(",",".")):BigDecimal.valueOf(0)	,iibbAmount: BigDecimal.valueOf(0),indirectOverheadPercentage: BigDecimal.valueOf(0),	indirectOverheadAmount:fields[19]?new BigDecimal(fields[19].replace("+","").replace(",",".")):BigDecimal.valueOf(0),	profitPercentage:fields[12]?new BigDecimal(fields[12].replace("+","").replace(",",".")):BigDecimal.valueOf(0),profitAmount: BigDecimal.valueOf(0),ivaPercentage:fields[20]?new BigDecimal(fields[20].replace("+","").replace(",",".")):BigDecimal.valueOf(0),totalAmount:fields[8]?new BigDecimal(fields[8].replace("+","").replace(",",".")):BigDecimal.valueOf(0),hasWork: hasWork )
				budget.save(flush: true, failOnError: true)
				
				if(hasWork){
					Work work = new Work(date: date, client: Client.findByCuit(fields[1]), code:fields[4].toLong(),name:fields[5]?.trim()?.replace("\"", ""),type:"building",finished:fields[21]==1?true:false, budget: budget)
					work.save(flush: true, failOnError:true)
				}
				
			}
		}else if (datatype == "budgetItems"){ 
			List notFoundBudgets = new ArrayList()
			file.inputStream.splitEachLine(delimiter) { fields ->
				if(fields[3]){
					Budget budget = Budget.findByOldCode(fields[0].toLong())
					if(budget){
						
						String conceptName = fields[2].replaceAll("\"","")
						Concept concept = Concept.findByDescription(fields[2].replaceAll("\"",""))?:Concept.findByCode("L101")
						BudgetItem item = new BudgetItem(budget:budget, concept: concept,amount: new BigDecimal(fields[3].replace("+","").replace(",",".") ))
						budget.addToItems(item)
						budget.save(flush: true,failOnError: true)
					} else{
						notFoundBudgets.add(fields[0].toLong())
					}
				}
			}
		}else if (datatype == "movement"){ 
			file.inputStream.splitEachLine(delimiter) {fields  ->
				String type = fields[2].toLowerCase().replace("\"","")
				if (type in ['op', 'os', 'in', 'tr', 'fi']){
				
					Date date = DATE_FORMAT.parse(fields[4].replaceAll("/([0-9]{2}) ", "/20\$1 ").replaceAll("\"",""))
					Date checkedDate = fields[8]?DATE_FORMAT.parse(fields[8].replaceAll("/([0-9]{2}) ", "/20\$1 ").replaceAll("\"","")):null
					int year = ("20" + fields[3]).replaceAll("\"","").toInteger()
					Movement movement = new Movement(type: type, number: fields[1].toLong(),checked: fields[8],year:year ,note: fields[9]?.replaceAll("\"",""),date: date, checkedDate:checkedDate)
					movement.save(flush: true, failOnError:true)
				}
			}
		
		}else if (datatype == "movementItems"){ 
			file.inputStream.splitEachLine(delimiter) {fields  ->
				MovementItem item = new MovementItem()
			}
		
		}else if (datatype == "payment"){ 
			file.inputStream.splitEachLine(delimiter) {fields  ->
				Payment payment = new Payment()
			}
		
		}else if (datatype == "supplierBudget"){ 
			file.inputStream.splitEachLine(delimiter) {  ->
				String code = SUPPLIER_TRANSFORM[fields[2]]?:fields[2]
				Supplier supplier = Supplier.findByCuit(code)
				
				Date date = DATE_FORMAT.parse(fields[5].replaceAll("/([0-9]{2}) ", "/20\$1 ").replaceAll("\"",""))
				SupplierBudget budget = new SupplierBudget(work: Work.findByCode(fields[1].toLong()),supplier: supplier,concept: Concept.findByCode(fields[3].trim().replace("\"","")),amount: new BigDecimal(fields[4].replace("+","").replace(",",".")), iva: new BigDecimal(fields[6].replace("+","").replace(",",".")), note: fields[7],date: date)
				budget.save(flush: true, failOnError: true)
			}
		}
		
		flash.message = 'Importación realizada correctamente'
		redirect(action:'index')
	}
}
