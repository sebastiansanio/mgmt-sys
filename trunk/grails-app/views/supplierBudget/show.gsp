
<%@ page import="mgmt.work.SupplierBudget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplierBudget.label', default: 'SupplierBudget')}" />
</head>

<body>

<section id="show-supplierBudget" class="first">

	<table class="table">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.supplier.label" default="Supplier" /></td>
				
				<td valign="top" class="value"><g:link controller="supplier" action="show" id="${supplierBudgetInstance?.supplier?.id}">${supplierBudgetInstance?.supplier?.encodeAsHTML()}</g:link></td>
				
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.concept.label" default="Concept" /></td>
				
				<td valign="top" class="value"><g:link controller="concept" action="show" id="${supplierBudgetInstance?.concept?.id}">${supplierBudgetInstance?.concept?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.amount.label" default="Amount" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierBudgetInstance, field: "amount")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.iva.label" default="Iva" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierBudgetInstance, field: "iva")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.work.label" default="Work" /></td>
				
				<td valign="top" class="value"><g:link controller="work" action="show" id="${supplierBudgetInstance?.work?.id}">${supplierBudgetInstance?.work?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.note.label" default="Note" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierBudgetInstance, field: "note")}</td>
				
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${supplierBudgetInstance?.dateCreated}" /></td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplierBudget.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${supplierBudgetInstance?.lastUpdated}" /></td>
				
			</tr>
		
		
		
		</tbody>
	</table>
</section>

</body>

</html>