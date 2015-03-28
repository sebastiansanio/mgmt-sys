package mgmt.movement



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MovementItemController {

    def index(Integer max) {
        params.max = Math.min(max ?: 50, 1000)
        respond MovementItem.list(params), model:[movementItemInstanceCount: MovementItem.count()]
    }
	
	def search(Integer max) {
		params.max = Math.min(max ?: 50, 1000)
		String nameQuery = "%"+params.description+"%"
		respond MovementItem.findAllByDescriptionLike(nameQuery,params), model:[movementItemInstanceCount: MovementItem.countByDescriptionLike(nameQuery)],  view:'index'
	}

 
}
