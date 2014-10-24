
<%@ page import="mgmt.payment.Invoice" %>
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
				<td valign="top" class="name"><g:message code="invoice.date.label" default="Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${invoiceInstance?.date}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoice.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${invoiceInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoice.lastUpdated.label" default="Last Updated" /></td>
				
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
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoice.type.label" default="Type" /></td>
				
				<td valign="top" class="value"><g:link controller="invoiceType" action="show" id="${invoiceInstance?.type?.id}">${invoiceInstance?.type?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoice.work.label" default="Work" /></td>
				
				<td valign="top" class="value"><g:link controller="work" action="show" id="${invoiceInstance?.work?.id}">${invoiceInstance?.work?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>