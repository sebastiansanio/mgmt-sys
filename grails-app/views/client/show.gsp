
<%@ page import="mgmt.persons.Client" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
</head>

<body>

<section id="show-client" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "name")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.businessName.label" default="Business Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "businessName")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.cuit.label" default="Cuit" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "cuit")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.address.label" default="Address" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "address")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.location.label" default="Location" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "location")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.province.label" default="Province" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "province")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.zipCode.label" default="Zip Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "zipCode")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.note.label" default="Note" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: clientInstance, field: "note")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${clientInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="client.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${clientInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
	
	
<sec:access url="/client/delete">
<g:if test="${!clientInstance.works && !clientInstance.budgets}">
	<g:form action="delete">
		<g:hiddenField name="_method" value="DELETE" />
		<g:hiddenField name="id" value="${clientInstance.id}" />
		<g:submitButton onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger" name="delete" value="${message(code:'default.button.delete.label') }" /> 
	</g:form>
</g:if>
</sec:access>	
	
</section>

</body>

</html>