
<%@ page import="mgmt.persons.Supplier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-supplier" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "name")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.address.label" default="Address" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "address")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${supplierInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${supplierInstance?.lastUpdated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.location.label" default="Location" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "location")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.note.label" default="Note" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "note")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.province.label" default="Province" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "province")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.zipCode.label" default="Zip Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "zipCode")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>