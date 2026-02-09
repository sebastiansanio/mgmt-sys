package mgmt.index


import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import groovy.sql.Sql

import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.CreationHelper

import pl.touk.excel.export.WebXlsxExporter

@Transactional(readOnly = true)
class PriceIndexItemController {

	def dataSource
	private static final String QUERY = """
		select distinct STR_TO_DATE(DATE_FORMAT(mi.date, '%Y-%m-01'),'%Y-%m-%d') dateValue,
		pi.name priceIndex, pi.id priceIndexId
		from movement_item mi inner join price_index pi on 1=1 
		where DATE_FORMAT(mi.date, '%Y-%m-01') not in 
		(select DATE_FORMAT(pii.date, '%Y-%m-01') from price_index_item pii where index_id = pi.id)
		order by 1 desc, 2 desc
	"""

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	private static List FIELDS = ["index","date","indexValue","dateCreated","lastUpdated"]

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
		params.sort = params.sort ?: 'date'
		params.order = params.order ?: 'desc'
		def priceIndexItemList = PriceIndexItem.createCriteria().list(params) {
			if(params.indexId){
				eq("index.id",params.long('indexId'))
			}
		}


        respond priceIndexItemList, model:[priceIndexItemInstanceCount: priceIndexItemList.totalCount]
    }

    def show(PriceIndexItem priceIndexItemInstance) {
        respond priceIndexItemInstance
    }

    def create() {
        respond new PriceIndexItem(params)
    }

    @Transactional
    def save(PriceIndexItem priceIndexItemInstance) {
        if (priceIndexItemInstance == null) {
            notFound()
            return
        }

        if (priceIndexItemInstance.hasErrors()) {
            respond priceIndexItemInstance.errors, view:'create'
            return
        }

        priceIndexItemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'priceIndexItem.label', default: 'PriceIndexItem'), priceIndexItemInstance.id])
                redirect priceIndexItemInstance
            }
            '*' { respond priceIndexItemInstance, [status: CREATED] }
        }
    }

    def edit(PriceIndexItem priceIndexItemInstance) {
        respond priceIndexItemInstance
    }

    @Transactional
    def update(PriceIndexItem priceIndexItemInstance) {
        if (priceIndexItemInstance == null) {
            notFound()
            return
        }

        if (priceIndexItemInstance.hasErrors()) {
            respond priceIndexItemInstance.errors, view:'edit'
            return
        }

        priceIndexItemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PriceIndexItem.label', default: 'PriceIndexItem'), priceIndexItemInstance.id])
                redirect priceIndexItemInstance
            }
            '*'{ respond priceIndexItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PriceIndexItem priceIndexItemInstance) {

        if (priceIndexItemInstance == null) {
            notFound()
            return
        }

        priceIndexItemInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PriceIndexItem.label', default: 'PriceIndexItem'), priceIndexItemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'priceIndexItem.label', default: 'PriceIndexItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

	def checkMissingValues(){
		def sql = new Sql(dataSource)
		def rows = sql.rows(QUERY)
		List missingValues = new ArrayList()
		rows.each { row ->
			Map missingValue = new HashMap()
			missingValue.dateValue = row.dateValue
			missingValue.priceIndex = row.priceIndex
			missingValue.priceIndexId = row.priceIndexId
			missingValues.add(missingValue)
		}
		sql.close()
		[missingValues: missingValues]
	}

	def download(){
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"Detalle de indices.xlsx\"");

		def headers = FIELDS.collect{
			message(code:'priceIndexItem.'+it+'.label')
		}
		new WebXlsxExporter().with {
			fillHeader(headers)
			add(PriceIndexItem.list(), FIELDS)

			CellStyle cellStyle = sheet.workbook.createCellStyle();
			CreationHelper createHelper = sheet.workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-mm-yy"));
			for(int i = 1;i <= PriceIndexItem.count(); i++){
				getCellAt(i, 1).setCellStyle(cellStyle)
				getCellAt(i, 3).setCellStyle(cellStyle)
				getCellAt(i, 4).setCellStyle(cellStyle)


			}
			for(int i = 0;i < FIELDS.size(); i++){
				sheet.autoSizeColumn(i)
			}

			save(response.outputStream)
		}
	}
}
