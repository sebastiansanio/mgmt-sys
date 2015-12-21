
<%@ page import="mgmt.movement.Movement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'movement.label', default: 'Movement')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<div class="row">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:select class="form-control" from="['all','checked','notChecked']" valueMessagePrefix="movement.checked" name="checked" value="${params.checked}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.filter.label')}" action="search" />
</div>
</g:form>
</div>


<section id="index-movement" class="first">
	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
				<th>${message(code:'default.edit.label')}</th>
				<th>${message(code: 'movement.type.label')}</th>
				<g:sortableColumn params="${params}" property="number" title="${message(code: 'movement.number.label')}" />
				<g:sortableColumn params="${params}" property="year" title="${message(code: 'movement.year.label')}" />
				<g:sortableColumn params="${params}" property="dateCreated" title="${message(code: 'movement.dateCreated.label')}" />
				<th>${message(code:'movement.amount.label')}</th>
				<th>${message(code:'movement.checked.label')}</th>
				<th>${message(code:'default.print.label')}</th>
				<th>${message(code:'movement.note.label')}</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${movementInstanceList}" status="i" var="movementInstance">
			<tr class="${movementInstance.checked ? 'checked-movement' : ''}">
				<td><g:link action="show" id="${movementInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td><g:link action="edit" id="${movementInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td><g:message code="movement.type.${movementInstance.type}" /></td>
				<td>${movementInstance.number}</td>
				<td>${movementInstance.year}</td>
				<td><g:formatDate date="${movementInstance.dateCreated}"/></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${movementInstance.amount}" /></td>
				<td><g:formatBoolean boolean="${movementInstance.checked}" /></td>
				<td><g:link controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode("fi").id}" params="${[movement_id:movementInstance.id]}"><span class="glyphicon glyphicon-download-alt"></span></g:link></td>
				<td>${movementInstance.note}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${movementInstanceCount}" params="${params}" />
	</div>
</section>

</body>

</html>