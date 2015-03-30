package mgmt.movement



import static org.springframework.http.HttpStatus.*

import java.util.List;

import grails.transaction.Transactional
import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class MovementItemController {

	private static List FIELDS = ["movement.year","movement.type","movement.number", "work","supplier","concept","description",
		"invoiceType","invoiceNumber","date","unit","quantity","unitPrice",
		"amount","iva","iibb","otherPerceptions","total","multiplier",
		"dateCreated","lastUpdated"]	
	
    def index(Integer max) {
        params.max = Math.min(max ?: 50, 1000)
        respond MovementItem.list(params), model:[movementItemInstanceCount: MovementItem.count()]
    }
	
	def search(Integer max) {
		params.max = Math.min(max ?: 50, 1000)
		String nameQuery = "%"+params.description+"%"
		respond MovementItem.findAllByDescriptionLike(nameQuery,params), model:[movementItemInstanceCount: MovementItem.countByDescriptionLike(nameQuery)],  view:'index'
	}
	
	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename='${message(code:'movements.label')}.xlsx'");
		
		def headers = FIELDS.collect{
			if(!it.contains("movement")){
				message(code:'movementItem.'+it+'.label')
			}else{
				message(code: it+'.label')
			}
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(MovementItem.list(), FIELDS)
			save(response.outputStream)
		}
	}

 
}
