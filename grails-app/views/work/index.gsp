
<%@ page import="mgmt.work.Work" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
</head>

<body>

<div class="row">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:field type="number" placeholder="${message(code:'work.code.label')}" class="form-control" name="code" value="${params.long('code')}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="search" />
</div>
</g:form>
</div>

<section id="index-work" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.show.label')}</th>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="code" title="${message(code: 'work.code.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="name" title="${message(code: 'work.name.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="type" title="${message(code: 'work.type.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="finished" title="${message(code: 'work.finished.label')}" />
				<th class="center-aligned"><g:message code="work.client.label" default="Client" /></th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${workInstanceList}" status="i" var="workInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="show" id="${workInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td class="center-aligned"><g:link action="edit" id="${workInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${workInstance.code}</td>
				<td>${fieldValue(bean: workInstance, field: "name")}</td>
				<td>${message(code:'work.type.'+workInstance.type)}</td>
				<td><g:formatBoolean boolean="${workInstance.finished}" /></td>
				<td>${fieldValue(bean: workInstance, field: "client")}</td>
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