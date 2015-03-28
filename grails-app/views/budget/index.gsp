
<%@ page import="mgmt.work.Budget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
</head>

<body>

<section id="index-budget" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
			
				<th><g:message code="budget.client.label" default="Client" /></th>
			
				<g:sortableColumn property="dateCrated" title="${message(code: 'budget.dateCrated.label', default: 'Date Crated')}" />
			
				<g:sortableColumn property="directCosts" title="${message(code: 'budget.directCosts.label', default: 'Direct Costs')}" />
			
				<g:sortableColumn property="iibbPercentage" title="${message(code: 'budget.iibbPercentage.label', default: 'Iibb Percentage')}" />
			
				<g:sortableColumn property="indirectOverheadPercentage" title="${message(code: 'budget.indirectOverheadPercentage.label', default: 'Indirect Overhead Percentage')}" />
			
				<g:sortableColumn property="ivaPercentage" title="${message(code: 'budget.ivaPercentage.label', default: 'Iva Percentage')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${budgetInstanceList}" status="i" var="budgetInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${budgetInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: budgetInstance, field: "client")}</td>
			
				<td><g:formatDate date="${budgetInstance.dateCrated}" /></td>
			
				<td>${fieldValue(bean: budgetInstance, field: "directCosts")}</td>
			
				<td>${fieldValue(bean: budgetInstance, field: "iibbPercentage")}</td>
			
				<td>${fieldValue(bean: budgetInstance, field: "indirectOverheadPercentage")}</td>
			
				<td>${fieldValue(bean: budgetInstance, field: "ivaPercentage")}</td>
			
				<td>${fieldValue(bean: budgetInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: budgetInstance, field: "profitPercentage")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${budgetInstanceCount}" />
	</div>
</section>

</body>

</html>