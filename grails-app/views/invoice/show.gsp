
<%@ page import="mgmt.procurement.Invoice" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-invoice" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="default.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${invoiceInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoice.description.label" default="Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: invoiceInstance, field: "description")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="default.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${invoiceInstance?.lastUpdated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoice.number.label" default="Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: invoiceInstance, field: "number")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoice.supplier.label" default="Supplier" /></td>
				
				<td valign="top" class="value"><g:link controller="supplier" action="show" id="${invoiceInstance?.supplier?.id}">${invoiceInstance?.supplier?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>