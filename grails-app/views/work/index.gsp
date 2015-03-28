
<%@ page import="mgmt.work.Work" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
</head>

<body>

<section id="index-work" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
			
				<th><g:message code="work.client.label" default="Client" /></th>
			
				<g:sortableColumn property="type" title="${message(code: 'work.type.label', default: 'Type')}" />
			
				<th><g:message code="work.budget.label" default="Budget" /></th>
			
				<g:sortableColumn property="code" title="${message(code: 'work.code.label', default: 'Code')}" />
			
				<g:sortableColumn property="finished" title="${message(code: 'work.finished.label', default: 'Finished')}" />
			
				<g:sortableColumn property="name" title="${message(code: 'work.name.label', default: 'Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${workInstanceList}" status="i" var="workInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${workInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: workInstance, field: "client")}</td>
			
				<td>${fieldValue(bean: workInstance, field: "type")}</td>
			
				<td>${fieldValue(bean: workInstance, field: "budget")}</td>
			
				<td>${fieldValue(bean: workInstance, field: "code")}</td>
			
				<td><g:formatBoolean boolean="${workInstance.finished}" /></td>
			
				<td>${fieldValue(bean: workInstance, field: "name")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${workInstanceCount}" />
	</div>
</section>

</body>

</html>