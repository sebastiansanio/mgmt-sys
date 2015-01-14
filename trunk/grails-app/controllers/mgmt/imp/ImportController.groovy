package mgmt.imp

import grails.transaction.Transactional
import mgmt.account.Account
import mgmt.account.AccountType
import mgmt.concept.Concept
import mgmt.concept.ConceptAccount
import mgmt.concept.ConceptGroup
import mgmt.persons.Client
import mgmt.persons.Supplier
import mgmt.work.Work



class ImportController {

	private static final String delimiter = ";"
	
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
				new Concept(conceptAccount:conceptAccount,conceptGroup:conceptGroup,code:fields[3],description:fields[4]).save(flush:true,failOnError:true)
			}
		} else if (datatype == "suppliers"){
			file.inputStream.splitEachLine(delimiter) { fields ->
				log.error(fields[3])
				new Supplier(name:fields[1]?.trim(),businessName:fields[2]?.trim(),cuit:fields[3]?.trim()).save(failOnError:true)
				
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
				new Work(code:fields[4].toLong(),name:fields[5]?.trim(),type:fields[7]?.trim(),finished:fields[21]=="VERDADERO"?true:false).save(failOnError:true)
			}
		}
		flash.message = 'Importación realizada correctamente'
		redirect(action:'index')
	}
}
