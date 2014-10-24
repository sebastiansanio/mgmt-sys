
<%@ page import="mgmt.payment.InvoiceType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'invoiceType.label', default: 'InvoiceType')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-invoiceType" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="invoiceType.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: invoiceTypeInstance, field: "code")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>