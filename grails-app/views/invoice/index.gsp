
<%@ page import="mgmt.payment.Invoice" %>
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
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="date" title="${message(code: 'invoice.date.label', default: 'Date')}" />
			
				<g:sortableColumn property="dateCreated" title="${message(code: 'invoice.dateCreated.label', default: 'Date Created')}" />
			
				<g:sortableColumn property="lastUpdated" title="${message(code: 'invoice.lastUpdated.label', default: 'Last Updated')}" />
			
				<g:sortableColumn property="number" title="${message(code: 'invoice.number.label', default: 'Number')}" />
			
				<th><g:message code="invoice.supplier.label" default="Supplier" /></th>
			
				<th><g:message code="invoice.type.label" default="Type" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${invoiceInstanceList}" status="i" var="invoiceInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${invoiceInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td><g:formatDate date="${invoiceInstance.date}" /></td>
			
				<td><g:formatDate date="${invoiceInstance.dateCreated}" /></td>
			
				<td><g:formatDate date="${invoiceInstance.lastUpdated}" /></td>
			
				<td>${fieldValue(bean: invoiceInstance, field: "number")}</td>
			
				<td>${fieldValue(bean: invoiceInstance, field: "supplier")}</td>
			
				<td>${fieldValue(bean: invoiceInstance, field: "type")}</td>
			
				<td>${fieldValue(bean: invoiceInstance, field: "work")}</td>
			
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