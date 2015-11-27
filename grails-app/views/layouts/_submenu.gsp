<sec:ifLoggedIn>
<g:if test="${params.controller	&& !(params.controller in ['home','login','accountStatus'])}" >
	<g:set var="menuName" value="${message(code: 'menu.'+params.controller+'.label')}" />
	<g:set var="validUris" value="${grailsApplication.controllerClasses.find{it.logicalPropertyName == params.controller}.uris}" />
	<h4>${menuName}</h4>
	<ul id="Menu" class="nav nav-pills margin-top-small">
		<li class="${ params.action == "index" ? 'active' : '' }">
			<g:if test="${ params.action != "index"}">
				<g:link	action="index">
					<i class="glyphicon glyphicon-th-list"></i>
					<g:message code="default.list.label" />
				</g:link>
			</g:if>
			<g:else>
				<a href="#">
					<i class="glyphicon glyphicon-th-list"></i>
					<g:message code="default.list.label" />
				</a>
			</g:else>
		</li>
		<g:if test="${validUris.contains('/'+params.controller+'/create')}" >
		<li class="${ params.action == "create" ? 'active' : '' }">
			<g:if test="${ params.action != "create"}">
				<g:link	action="create">
					<i class="glyphicon glyphicon-plus"></i>
					<g:message code="default.create.label" />
				</g:link>
			</g:if>
			<g:else>
				<a href="#">
					<i class="glyphicon glyphicon-plus"></i>
					<g:message code="default.create.label" />
				</a>
			</g:else>
		</li>
		</g:if>
		<g:if test="${ params.action == 'show' || params.action == 'edit' }">
		<sec:access url="/${params.controller}/edit">
		<li class="${ params.action == "edit" ? 'active' : '' }">
			<g:if test="${ params.action != "edit"}">
				<g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> <g:message code="default.edit.label"></g:message></g:link>
			</g:if>
			<g:else>
				<a href="#" ><i class="glyphicon glyphicon-pencil"></i> <g:message code="default.edit.label"></g:message></a>
			</g:else>
		</li>
		</sec:access>
		</g:if>
		<g:if test ="${validUris.contains('/'+params.controller+'/download')}">
			<sec:access url="/${params.controller}/download">
			<li>
				<g:link action="download"><i class="glyphicon glyphicon-download-alt"></i> <g:message code="default.download.label"></g:message></g:link>
			</li>
			</sec:access>
		</g:if>
	</ul>
</g:if>
</sec:ifLoggedIn>