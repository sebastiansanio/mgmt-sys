grails.servlet.version = "3.0" 
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6

grails.project.fork = [

    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven"
grails.project.dependency.resolution = {
    inherits("global") {
    }
    log "error" 
    checksums true 
    legacyResolve false 

    repositories {
        inherits true 

		mavenRepo "http://repo.grails.org/grails/core"
		mavenRepo "http://jaspersoft.artifactoryonline.com/jaspersoft/third-party-ce-artifacts/"
		mavenRepo "http://jasperreports.sourceforge.net/maven2/"
		
		mavenCentral()																								
		grailsPlugins()
        grailsHome()
        mavenLocal()
        grailsCentral()
        
    }

    dependencies {
        test "org.grails:grails-datastore-test-support:1.0-grails-2.4"
		runtime 'mysql:mysql-connector-java:5.1.34'
		compile 'commons-beanutils:commons-beanutils:1.8.3'
		compile "net.sf.jasperreports:jasperreports:6.0.4"
		
    }

    plugins {
        build ":tomcat:7.0.55"

        compile ":scaffolding:2.1.2"
        compile ':cache:1.1.7'
        compile ":asset-pipeline:1.9.6"
		compile ":spring-security-core:2.0-RC4"
		
        runtime ":hibernate4:4.3.5.5" 
        runtime ":database-migration:1.4.0"
        runtime ":jquery:1.11.1"
		compile ":excel-export:0.2.1"
		
    }
}
