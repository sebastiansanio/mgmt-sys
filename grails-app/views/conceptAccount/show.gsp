
<%@ page import="mgmt.concept.ConceptAccount" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'conceptAccount.label', default: 'ConceptAccount')}" />
</head>

<body>

<section id="show-conceptAccount" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="conceptAccount.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: conceptAccountInstance, field: "name")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="conceptAccount.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${conceptAccountInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="conceptAccount.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${conceptAccountInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
	
<sec:access url="/conceptAccount/delete">
	<g:form action="delete">
		<g:hiddenField name="_method" value="DELETE" />
		<g:hiddenField name="id" value="${conceptAccountInstance.id}" />
		<g:submitButton class="btn btn-danger" name="delete" value="${message(code:'default.button.delete.label') }" /> 
	</g:form>
</sec:access>
</section>

</body>

</html>