
<%@ page import="mgmt.procurement.Invoice" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-invoice" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<g:sortableColumn property="number" title="${message(code: 'invoice.number.label', default: 'Number')}" />
			
				<g:sortableColumn property="dateCreated" title="${message(code: 'default.dateCreated.label', default: 'Date Created')}" />
			
				<g:sortableColumn property="description" title="${message(code: 'invoice.description.label', default: 'Description')}" />
			
				<g:sortableColumn property="lastUpdated" title="${message(code: 'default.lastUpdated.label', default: 'Last Updated')}" />
			
				<th><g:message code="invoice.supplier.label" default="Supplier" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${invoiceInstanceList}" status="i" var="invoiceInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${invoiceInstance.id}">${fieldValue(bean: invoiceInstance, field: "number")}</g:link></td>
			
				<td><g:formatDate date="${invoiceInstance.dateCreated}" /></td>
			
				<td>${fieldValue(bean: invoiceInstance, field: "description")}</td>
			
				<td><g:formatDate date="${invoiceInstance.lastUpdated}" /></td>
			
				<td>${fieldValue(bean: invoiceInstance, field: "supplier")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${invoiceInstanceCount}" />
	</div>
</section>

</body>

</html>