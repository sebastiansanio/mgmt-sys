
<%@ page import="mgmt.payment.PaymentOrder" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'paymentOrder.label', default: 'PaymentOrder')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
	<g:set var="noSubMenu" value="${true}" scope="request" />
</head>

<body>
<g:render template="submenu"/>
<section id="show-paymentOrder" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="paymentOrder.type.label" default="Type" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: paymentOrderInstance, field: "type")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="paymentOrder.number.label" default="Number" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: paymentOrderInstance, field: "number")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="paymentOrder.date.label" default="Date" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${paymentOrderInstance?.date}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="paymentOrder.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${paymentOrderInstance?.dateCreated}" /></td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="paymentOrder.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${paymentOrderInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>