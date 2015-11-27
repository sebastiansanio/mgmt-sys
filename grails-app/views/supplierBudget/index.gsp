
<%@ page import="mgmt.work.SupplierBudget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplierBudget.label', default: 'SupplierBudget')}" />
</head>

<body>

<section id="index-supplierBudget" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
				<th><g:message code="supplierBudget.supplier.label" default="Supplier" /></th>
				<th><g:message code="supplierBudget.concept.label" default="Concept" /></th>
				<g:sortableColumn property="amount" title="${message(code: 'supplierBudget.amount.label', default: 'Amount')}" />
				<g:sortableColumn property="iva" title="${message(code: 'supplierBudget.iva.label', default: 'Iva')}" />
				<th><g:message code="supplierBudget.work.label" default="Work" /></th>
				<th><g:message code="supplierBudget.note.label" /></th>
				<g:sortableColumn property="dateCreated" title="${message(code: 'default.dateCreated.label')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${supplierBudgetInstanceList}" status="i" var="supplierBudgetInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${supplierBudgetInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "supplier")}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "concept")}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "amount")}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "iva")}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "work")}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "note")}</td>
				<td><g:formatDate date="${supplierBudgetInstance.dateCreated}" /></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${supplierBudgetInstanceCount}" />
	</div>
</section>

</body>

</html>