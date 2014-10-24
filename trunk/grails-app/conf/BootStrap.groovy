import mgmt.payment.Invoice
import mgmt.payment.InvoiceType
import mgmt.persons.Supplier
import mgmt.security.Requestmap
import mgmt.security.SecAuthority
import mgmt.security.SecUser
import mgmt.security.SecUserSecAuthority

class BootStrap {

	def init = { servletContext ->

		SecUser user = new SecUser(username: 'urbatec' ,password: 'urbatec',name: 'Urbatec').save(flush: true)
		SecAuthority authority = new SecAuthority(authority: 'AUTH_USER').save(flush: true)
		SecUserSecAuthority.create(user,authority,true)
		
		for (String url in [
	      '/**/favicon.ico',
	      '/assets/**', '/**/js/**', '/**/css/**', '/**/images/**',
	      '/login', '/login.*', '/login/*',
	      '/logout', '/logout.*', '/logout/*', '/dbconsole/**', '/fonts/**']) {
			new Requestmap(url: url, configAttribute: 'permitAll').save(flush: true)
		}
		
		new Requestmap(url: '/supplier/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/invoice/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/invoiceType/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/work/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/', configAttribute: "isAuthenticated()").save(flush: true)
		 
		
		new InvoiceType(code:'A').save()
		new InvoiceType(code:'B').save()
		
		
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
