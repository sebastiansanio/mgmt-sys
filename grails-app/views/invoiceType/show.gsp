
<%@ page import="mgmt.invoice.InvoiceType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'invoiceType.label', default: 'InvoiceType')}" />
</head>

<body>

<section id="show-invoiceType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoiceType.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: invoiceTypeInstance, field: "code")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoiceType.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${invoiceTypeInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoiceType.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${invoiceTypeInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>