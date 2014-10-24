import mgmt.core.Work
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
		SecAuthority authorityUser = new SecAuthority(authority: 'AUTH_USER').save(flush: true)
		SecUserSecAuthority.create(user,authorityUser,true)

		SecUser admin = new SecUser(username: 'admin' ,password: 'admin',name: 'Administrador').save(flush: true)
		SecAuthority authorityAdmin = new SecAuthority(authority: 'AUTH_ADMIN').save(flush: true)
		SecUserSecAuthority.create(admin,authorityAdmin,true)
		
				
		for (String url in [
	      '/**/favicon.ico',
	      '/assets/**', '/**/js/**', '/**/css/**', '/**/images/**',
	      '/login', '/login.*', '/login/*',
	      '/logout', '/logout.*', '/logout/*', '/dbconsole/**', '/fonts/**']) {
			new Requestmap(url: url, configAttribute: 'permitAll').save(flush: true)
		}
		
		new Requestmap(url: '/supplier/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/invoice/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/invoiceType/**', configAttribute: "hasRole('AUTH_ADMIN')").save(flush: true)
		new Requestmap(url: '/work/**', configAttribute: "hasRole('AUTH_ADMIN')").save(flush: true)
		new Requestmap(url: '/', configAttribute: "isAuthenticated()").save(flush: true)
		 
		
		def invoiceTypeA = new InvoiceType(code:'A').save(flush:true)
		new InvoiceType(code:'B').save(flush:true)
				
		def work = new Work(name: 'Obra X').save(flush:true)
		
		for(int i=1;i<=100;i++){
			def supplier = new Supplier(cuit:i.hashCode().toString(),name:"Proveedor "+i)
			supplier.save(flush:true)
			for(int j=1;j<=50;j++){
				def invoice = new Invoice(date: new Date(),work:work,type:invoiceTypeA,number:j,description:supplier.toString() +': factura '+j,supplier:supplier)
				invoice.save(flush:true)
			}
		}
	}
	def destroy = {
	}
}
