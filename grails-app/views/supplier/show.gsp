
<%@ page import="mgmt.persons.Supplier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
</head>

<body>

<section id="show-supplier" class="first">

	<table class="table">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.businessName.label" default="Business Name" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "businessName")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.name.label" default="Name" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "name")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.cuit.label" default="Cuit" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "cuit")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.address.label" default="Address" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "address")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.location.label" default="Location" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "location")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.province.label" default="Province" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "province")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.zipCode.label" default="Zip Code" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "zipCode")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.note.label" default="Note" /></td>
				<td valign="top" class="value">${fieldValue(bean: supplierInstance, field: "note")}</td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.dateCreated.label" default="Date Created" /></td>
				<td valign="top" class="value"><g:formatDate date="${supplierInstance?.dateCreated}" /></td>
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="supplier.lastUpdated.label" default="Last Updated" /></td>
				<td valign="top" class="value"><g:formatDate date="${supplierInstance?.lastUpdated}" /></td>
			</tr>
		
		</tbody>
	</table>
	
	
<sec:access url="/supplier/delete">
<g:if test="${!supplierInstance.movements}">
	<g:form action="delete">
		<g:hiddenField name="_method" value="DELETE" />
		<g:hiddenField name="id" value="${supplierInstance.id}" />
		<g:submitButton onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger" name="delete" value="${message(code:'default.button.delete.label') }" /> 
	</g:form>
</g:if>
</sec:access>

</section>

</body>

</html>