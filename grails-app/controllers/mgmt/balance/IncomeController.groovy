package mgmt.balance


class IncomeController {

    def index() { }

	def download(){
		redirect(controller: 'report', action: 'downloadReport', params: params)

	}


}
