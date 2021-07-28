package mgmt.movement



import static org.springframework.http.HttpStatus.*

import java.util.List;

import grails.transaction.Transactional
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper
import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class MovementItemController {

	private static List FIELDS = ["movement.year","movement.type","movement.number", "work","supplier","concept","description",
		"invoiceType","invoiceNumber","date","unit","quantity","unitPrice",
		"amount","iva","iibb","otherPerceptions","total","multiplier",
		"dateCreated","lastUpdated"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'dateCreated'
		params.order = params.order ?: 'desc'
        respond MovementItem.list(params), model:[movementItemInstanceCount: MovementItem.count()]
    }

	def search(Integer max) {
		params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'dateCreated'
		params.order = params.order ?: 'desc'
		String nameQuery = "%"+params.description+"%"
		respond MovementItem.findAllByDescriptionLike(nameQuery,params), model:[movementItemInstanceCount: MovementItem.countByDescriptionLike(nameQuery)],  view:'index'
	}

	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"${message(code:'movements.label')}.xlsx\"");

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

			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			for(int i = 1;i <= MovementItem.count(); i++){
				getCellAt(i, 9).setCellStyle(cellStyle)
				getCellAt(i, 19).setCellStyle(cellStyle)
				getCellAt(i, 20).setCellStyle(cellStyle)
			}
			for(int i = 0;i < FIELDS.size(); i++){
				sheet.autoSizeColumn(i)
			}

			save(response.outputStream)
		}
	}


}
