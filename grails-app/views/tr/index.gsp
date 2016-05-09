<%@ page import="mgmt.movement.Movement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'movement.label')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<div class="row margin-top-medium">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:select class="form-control" from="['all','checked','notChecked']" valueMessagePrefix="movement.checked" name="checked" value="${params.checked}" />
</div>
<div class="col-md-2">
<g:field type="number" placeholder="${message(code:'movement.number.label')}" class="form-control" name="number" value="${params.number}" />
</div>
<div class="col-md-2">
<g:field type="number" placeholder="${message(code:'movement.year.label')}" class="form-control" name="year" value="${params.year}" />
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
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<th class="center-aligned">${message(code: 'movement.type.label')}</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="number" title="${message(code: 'movement.number.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="year" title="${message(code: 'movement.year.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="dateCreated" title="${message(code: 'movement.dateCreated.label')}" />
				<th class="center-aligned">${message(code:'movement.amount.label')}</th>
				<sec:access url="/tr/check">
				<g:sortableColumn class="center-aligned" params="${params}" property="checked" title="${message(code: 'movement.checked.label')}" />
				</sec:access>
				<th class="center-aligned">${message(code:'default.print.label')}</th>
				
				<sec:access url="/tr/delete">
				<th class="center-aligned">${message(code:'default.button.delete.label')}</th>
				</sec:access>
				<th class="center-aligned">${message(code:'movement.note.label')}</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${movementInstanceList}" status="i" var="movementInstance">
			<tr class="${movementInstance.checked ? 'checked-movement' : ''}">
				<td class="center-aligned"><g:link action="edit" id="${movementInstance.id}"><span class="glyphicon glyphicon glyphicon-pencil"></span></g:link></td>
				<td class="center-aligned importantBig"><g:message code="movement.type.${movementInstance.type}" /></td>
				<td class="center-aligned importantBig">${movementInstance.number}</td>
				<td class="center-aligned importantBig">${movementInstance.year}</td>
				<td class="center-aligned"><g:formatDate date="${movementInstance.dateCreated}"/></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${movementInstance.amount}" /></td>
				<sec:access url="/tr/check">
				<td class="center-aligned">
				<g:if test="${!movementInstance.checked}">
					<sec:access url="/tr/check">
						<g:form action="check">
							<g:hiddenField name="id" value="${movementInstance.id}" />
							<g:hiddenField name="max" value="${params.max}" />
							<g:hiddenField name="sort" value="${params.sort}" />
							<g:hiddenField name="order" value="${params.order}" />
							<g:hiddenField name="offset" value="${params.offset}" />
							<g:submitButton class="btn btn-primary btn-xs" name="check" value="${message(code:'movement.check.label') }" /> 
						</g:form>
					</sec:access>
				</g:if>
				<g:else>
					<sec:access url="/tr/uncheck">
						<g:form action="uncheck">
							<g:hiddenField name="id" value="${movementInstance.id}" />
							<g:hiddenField name="max" value="${params.max}" />
							<g:hiddenField name="sort" value="${params.sort}" />
							<g:hiddenField name="order" value="${params.order}" />
							<g:hiddenField name="offset" value="${params.offset}" />
							<g:submitButton class="btn btn-danger btn-xs" name="uncheck" value="${message(code:'movement.uncheck.label') }" /> 
						</g:form>
					</sec:access>
				</g:else>
				
				</td>
				</sec:access>
				<td class="center-aligned"><g:link target="_blank" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode("tr").id}" params="${[movement_id:movementInstance.id]}"><span class="glyphicon glyphicon-download-alt"></span></g:link></td>
				
				<sec:access url="/tr/delete"><td class="center-aligned">
				<g:if test="${!movementInstance.checked}">
				<g:form action="delete">
					<g:hiddenField name="_method" value="DELETE" />
					<g:hiddenField name="id" value="${movementInstance.id}" />
					<button onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger btn-xs" name="delete"><span class="glyphicon glyphicon-trash"></span> </button>
				</g:form>
				</g:if>
				</td></sec:access>
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