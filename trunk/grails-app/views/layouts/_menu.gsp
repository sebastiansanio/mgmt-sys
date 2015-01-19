<sec:ifLoggedIn>
<nav class="navbar navbar-default" role="navigation">
	<div class="collapse navbar-collapse">
		<ul class="nav navbar-nav">
			<g:each status="i" var="c" in="${grailsApplication.controllerClasses.findAll{! (it.logicalPropertyName in ['assets','dbdoc','login','logout'])}.sort { it.logicalPropertyName} }">
				<sec:access url="/${c.logicalPropertyName}/index">
					<li class="${params.controller == c.logicalPropertyName ? "active" : ""}">
						<g:link	controller="${c.logicalPropertyName}" action="index">
							<g:message code="menu.${c.logicalPropertyName}.label" />
						</g:link>
					</li>
				</sec:access>
			</g:each>
		</ul>
	</div>
</nav>
</sec:ifLoggedIn>