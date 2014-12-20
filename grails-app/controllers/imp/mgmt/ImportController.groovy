package imp.mgmt

import mgmt.concept.Concept
import mgmt.concept.ConceptAccount
import mgmt.concept.ConceptGroup

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
				def conceptAccount = ConceptAccount.findByName(fields[1].toLong())
				if(!conceptAccount){
					conceptAccount = new ConceptAccount(name: fields[1])
					conceptAccount.save(flush:true)
				}
				def conceptGroup = ConceptGroup.findByName(fields[2].toLong())
				if(!conceptGroup){
					conceptGroup = new ConceptAccount(name: fields[2])
					conceptGroup.save(flush:true)
				}
				
				new Concept(id:fields[0],conceptAccount:conceptAccount,conceptGroup:conceptGroup,description:fields[3])
				System.out.println(fields)		
			}
		}
		flash.message = 'Importación realizada correctamente'
		redirect(action:'index')
	}
}
