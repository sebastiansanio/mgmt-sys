<ul class="nav nav-sidebar">
	<g:each status="i" var="c"	in="${grailsApplication.controllerClasses.findAll{! (it.logicalPropertyName in ['assets','dbdoc'])}.sort { it.logicalPropertyName } }">
		<li class="${params.controller == c.logicalPropertyName ? "active" : ""}">
			<g:link	controller="${c.logicalPropertyName}" action="index">
				<g:message code="menu.${c.logicalPropertyName}.label" />
			</g:link>
		</li>
	</g:each>
</ul>