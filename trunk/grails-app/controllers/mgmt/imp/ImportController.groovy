package mgmt.imp

import mgmt.concept.Concept
import mgmt.concept.ConceptAccount
import mgmt.concept.ConceptGroup
import mgmt.persons.Supplier

class ImportController {

	def index() {
	}

	def importData(){
		def datatype = params.datatype
		def file = request.getFile('file')
		if (file.isEmpty()) {
			flash.error = 'El archivo no puede estar vacío'
			redirect(action:'index')
			return
		}
		if(datatype == "concepts"){

			file.inputStream.splitEachLine(';') { fields ->
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
			file.inputStream.splitEachLine(';') { fields ->
				new Supplier(name:fields[1]?.trim(),businessName:fields[2]?.trim(),cuit:fields[3]?.trim()).save(failOnError:true)
			}
		} else if (datatype == "work"){
			file.inputStream.splitEachLine(';') { fields ->
				new Supplier(name:fields[1]?.trim(),businessName:fields[2]?.trim(),cuit:fields[3]?.trim()).save(failOnError:true)
			}
		}
		flash.message = 'Importación realizada correctamente'
		redirect(action:'index')
	}
}
