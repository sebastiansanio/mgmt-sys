
<%@ page import="mgmt.config.Parameter" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'parameter.label', default: 'Parameter')}" />
</head>

<body>

<section id="index-parameter" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.edit.label')}</th>
			
				<g:sortableColumn property="code" title="${message(code: 'parameter.code.label', default: 'Code')}" />
			
				<g:sortableColumn property="value" title="${message(code: 'parameter.value.label', default: 'Value')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${parameterInstanceList}" status="i" var="parameterInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${parameterInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
			
				<td>${fieldValue(bean: parameterInstance, field: "code")}</td>
			
				<td>${fieldValue(bean: parameterInstance, field: "value")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${parameterInstanceCount}" />
	</div>
</section>

</body>

</html>