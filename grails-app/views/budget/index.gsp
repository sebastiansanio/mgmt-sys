
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
			
				<g:sortableColumn property="name" title="${message(code: 'budget.name.label')}" />
				<th><g:message code="budget.client.label" default="Client" /></th>
				<g:sortableColumn property="hasWork" title="${message(code: 'budget.hasWork.label')}" />
				<g:sortableColumn property="directCosts" title="${message(code: 'budget.directCosts.label', default: 'Direct Costs')}" />
				<th><g:message code="budget.items.label" /></th>
				<g:sortableColumn property="totalAmount" title="${message(code: 'budget.pvai.label')}" />
				<th><g:message code="budget.iva.label" /></th>
				<th><g:message code="budget.pvii.label" /></th>
				<g:sortableColumn property="dateCreated" title="${message(code: 'budget.dateCreated.label', default: 'Date Created')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${budgetInstanceList}" status="i" var="budgetInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${budgetInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td>${fieldValue(bean: budgetInstance, field: "name")}</td>
				<td>${fieldValue(bean: budgetInstance, field: "client")}</td>
				<td><g:formatBoolean boolean="${budgetInstance.hasWork}" /></td>
				<td class="right-aligned">${fieldValue(bean: budgetInstance, field: "directCosts")}</td>
				<td class="right-aligned">${fieldValue(bean: budgetInstance, field: "generalExpendures")}</td>
				<td class="right-aligned">${fieldValue(bean: budgetInstance, field: "totalAmount")}</td>
				<td class="right-aligned">${fieldValue(bean: budgetInstance, field: "ivaAmount")}</td>
				<td class="right-aligned">${fieldValue(bean: budgetInstance, field: "totalAmountWithIva")}</td>
				<td><g:formatDate date="${budgetInstance.dateCreated}" /></td>
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