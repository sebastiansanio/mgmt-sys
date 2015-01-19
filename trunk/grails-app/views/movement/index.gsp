
<%@ page import="mgmt.movement.Movement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'movement.label', default: 'Movement')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>


<section id="index-movement" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
				
				<g:sortableColumn property="dateCreated" title="${message(code: 'movement.dateCreated.label')}" />
							
				<g:sortableColumn property="type" title="${message(code: 'movement.type.label')}" />
				
				<g:sortableColumn property="number" title="${message(code: 'movement.number.label')}" />
				
				
			</tr>
		</thead>
		<tbody>
		<g:each in="${movementInstanceList}" status="i" var="movementInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${movementInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>

				<td><g:formatDate date="${movementInstance.dateCreated}"/></td>
			
				<td><g:message code="movement.type.${movementInstance.type}" /></td>
				
				<td>${fieldValue(bean: movementInstance, field: "number")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${movementInstanceCount}" />
	</div>
</section>

</body>

</html>