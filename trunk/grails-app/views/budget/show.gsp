
<%@ page import="mgmt.work.Budget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
</head>

<body>

<section id="show-budget" class="first">

	<table class="table">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "name")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.client.label" default="Client" /></td>
				
				<td valign="top" class="value"><g:link controller="client" action="show" id="${budgetInstance?.client?.id}">${budgetInstance?.client?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${budgetInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.directCosts.label" default="Direct Costs" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "directCosts")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.iibbPercentage.label" default="Iibb Percentage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "iibbPercentage")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.indirectOverheadPercentage.label" default="Indirect Overhead Percentage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "indirectOverheadPercentage")}</td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.ivaPercentage.label" default="Iva Percentage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "ivaPercentage")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${budgetInstance?.lastUpdated}" /></td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="budget.profitPercentage.label" default="Profit Percentage" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "profitPercentage")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>