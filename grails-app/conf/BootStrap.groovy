import mgmt.payment.Invoice
import mgmt.persons.Supplier
import mgmt.security.Requestmap
import mgmt.security.SecAuthority
import mgmt.security.SecUser
import mgmt.security.SecUserSecAuthority

class BootStrap {

	def init = { servletContext ->

		SecUser user = new SecUser(username: 'urbatec' ,password: 'urbatec').save(flush: true)
		SecAuthority authority = new SecAuthority(authority: 'AUTH_USER').save(flush: true)
		SecUserSecAuthority.create(user,authority,true)
		
		for (String url in [
	      '/', '/index', '/index.gsp', '/**/favicon.ico',
	      '/assets/**', '/**/js/**', '/**/css/**', '/**/images/**',
	      '/login', '/login.*', '/login/*',
	      '/logout', '/logout.*', '/logout/*', '/dbconsole/**', '/fonts/**']) {
			new Requestmap(url: url, configAttribute: 'permitAll').save(flush: true)
		}
		
		new Requestmap(url: '/supplier/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/invoice/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		 
		for(int i=0;i<100;i++){
			def supplier = new Supplier(cuit:i.hashCode().toString(),name:"Proveedor "+i)
			supplier.save()
			for(int j=0;j<50;j++){
				def invoice = new Invoice(number:j,description:supplier.toString() +': factura '+j,supplier:supplier)
				invoice.save()
			}
		}
	}
	def destroy = {
	}
}
