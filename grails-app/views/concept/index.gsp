
<%@ page import="mgmt.core.Concept" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'concept.label', default: 'Concept')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-concept" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="code" title="${message(code: 'concept.code.label', default: 'Code')}" />
			
				<g:sortableColumn property="description" title="${message(code: 'concept.description.label', default: 'Description')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${conceptInstanceList}" status="i" var="conceptInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${conceptInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: conceptInstance, field: "code")}</td>
			
				<td>${fieldValue(bean: conceptInstance, field: "description")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${conceptInstanceCount}" />
	</div>
</section>

</body>

</html>