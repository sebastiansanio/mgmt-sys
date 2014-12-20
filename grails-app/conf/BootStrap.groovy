import java.text.DecimalFormat

import mgmt.core.Work
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
		
		SecUser developer = new SecUser(username: 'dev' ,password: 'dev',name: 'Developer').save(flush: true)
		SecAuthority authorityDeveloper = new SecAuthority(authority: 'AUTH_DEVELOPER').save(flush: true)
		SecUserSecAuthority.create(developer,authorityDeveloper,true)

				
		for (String url in [
	      '/**/favicon.ico',
	      '/assets/**', '/**/js/**', '/**/css/**', '/**/images/**',
	      '/login', '/login.*', '/login/*',
	      '/logout', '/logout.*', '/logout/*', '/dbconsole/**', '/fonts/**']) {
			new Requestmap(url: url, configAttribute: 'permitAll').save(flush: true)
		}
		
		new Requestmap(url: '/supplier/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/invoiceType/**', configAttribute: "hasRole('AUTH_ADMIN')").save(flush: true)
		new Requestmap(url: '/work/**', configAttribute: "hasRole('AUTH_ADMIN')").save(flush: true)
		new Requestmap(url: '/concept/**', configAttribute: "hasRole('AUTH_ADMIN')").save(flush: true)
		new Requestmap(url: '/paymentOrder/**', configAttribute: "hasRole('AUTH_USER')").save(flush: true)
		new Requestmap(url: '/', configAttribute: "isAuthenticated()").save(flush: true)
		new Requestmap(url: '/concept/**', configAttribute: "hasRole('AUTH_DEVELOPER')").save(flush: true)
		new Requestmap(url: '/import/**', configAttribute: "hasRole('AUTH_DEVELOPER')").save(flush: true)
		new Requestmap(url: '/**/**/**', configAttribute: "hasRole('AUTH_DEVELOPER')").save(flush: true)
		
		def invoiceTypeA = new InvoiceType(code:'A').save(flush:true)
		new InvoiceType(code:'B').save(flush:true)
				
		def work = new Work(name: 'Obra 1').save(flush:true)
		new Work(name: 'Obra 2').save(flush:true)
		new Work(name: 'Obra 3').save(flush:true)
		
		
	}
	def destroy = {
	}
}
