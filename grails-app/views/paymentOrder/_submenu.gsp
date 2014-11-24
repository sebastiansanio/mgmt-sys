
	<g:set var="menuName"
		value="${message(code: 'menu.'+params.controller+'.label')}" />
	<h4>
		${menuName}
	</h4>
	<ul id="Menu" class="nav nav-pills margin-top-small">

		<li class="${ params.action == "index" ? 'active' : '' }"><g:link
				action="index">
				<i class="glyphicon glyphicon-th-list"></i>
				<g:message code="default.list.label" />
			</g:link>
			
			<li class="${ params.action == "create" && params.type == "op" ? 'active' : '' }">
			<g:link	action="create" params="[type:'op']">
				<i class="glyphicon glyphicon-plus"></i>
				Nueva OP
			</g:link></li>
			
			<li class="${ params.action == "create" && params.type == "os" ? 'active' : '' }">
			<g:link action="create" params="[type:'os']">
				<i class="glyphicon glyphicon-plus"></i>
				Nueva OS
			</g:link></li>
			
			<g:if test="${ params.action == 'show' || params.action == 'edit' }">
			<li class="${ params.action == "edit" ? 'active' : '' }">
				<g:link action="edit" id="${params.id}"><i class="glyphicon glyphicon-pencil"></i> <g:message code="default.edit.label"></g:message></g:link>
			</li>
		</g:if>
	</ul>
