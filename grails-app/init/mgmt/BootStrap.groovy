package mgmt

import mgmt.security.Requestmap
import mgmt.security.SecAuthority
import mgmt.security.SecUser
import mgmt.security.SecUserSecAuthority
import grails.util.Holders

class BootStrap {

	def init = { servletContext ->

		// Migrate existing Requestmap entries: hasRole() → hasAuthority()
		// Required because Spring Security 4.x auto-prepends ROLE_ to hasRole() checks
		Requestmap.findAllByConfigAttributeLike('%hasRole(%').each { rm ->
			rm.configAttribute = rm.configAttribute.replace('hasRole(', 'hasAuthority(')
			rm.save(flush: true)
		}

		if(SecUser.count()==0){

			SecUser user = new SecUser(username: 'urbatec' ,password: 'urbatec',name: 'Urbatec').save(flush: true)
			SecAuthority authorityUser = new SecAuthority(authority: 'AUTH_USER').save(flush: true)
			SecUserSecAuthority.create(user,authorityUser,true)

			SecUser admin = new SecUser(username: 'admin' ,password: 'admin',name: 'Administrador').save(flush: true)
			SecAuthority authorityAdmin = new SecAuthority(authority: 'AUTH_ADMIN').save(flush: true)
			SecUserSecAuthority.create(admin,authorityAdmin,true)

			SecUser developer = new SecUser(username: 'dev' ,password: 'dev',name: 'Developer').save(flush: true)
			SecUserSecAuthority.create(developer,authorityUser,true)
			SecUserSecAuthority.create(developer,authorityAdmin,true)


			for (String url in [
				'/**/favicon.ico',
				'/assets/**',
				'/**/js/**',
				'/**/css/**',
				'/**/images/**',
				'/login',
				'/login.*',
				'/login/*',
				'/logout',
				'/logout.*',
				'/logout/*',
				'/dbconsole/**',
				'/fonts/**'
			]) {
				new Requestmap(url: url, configAttribute: 'permitAll').save(flush: true)
			}

			new Requestmap(url: '/', configAttribute: "isAuthenticated()").save(flush: true)

			new Requestmap(url: '/account/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)
			new Requestmap(url: '/accountType/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)

			new Requestmap(url: '/concept/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)
			new Requestmap(url: '/conceptAccount/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)
			new Requestmap(url: '/conceptGroup/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)

			new Requestmap(url: '/invoiceType/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)

			new Requestmap(url: '/movement/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)
			new Requestmap(url: '/movementItem/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)
			new Requestmap(url: '/op/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)
			new Requestmap(url: '/os/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)
			new Requestmap(url: '/tr/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)
			new Requestmap(url: '/fi/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)
			new Requestmap(url: '/in/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)

			new Requestmap(url: '/client/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)
			new Requestmap(url: '/supplier/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)

			new Requestmap(url: '/budget/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)
			new Requestmap(url: '/work/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)
			new Requestmap(url: '/supplierBudget/**', configAttribute: "hasAuthority('AUTH_USER')").save(flush: true)

			new Requestmap(url: '/import/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)

			new Requestmap(url: '/secUser/**', configAttribute: "hasAuthority('AUTH_ADMIN')").save(flush: true)

		}

		// Force reload Requestmap cache - in Grails 3 the security filter chain
		// initializes before BootStrap, so the cache is stale
		Holders.applicationContext.objectDefinitionSource.reset()
	}
	def destroy = {
	}
}
