
<%@ page import="mgmt.concept.ConceptGroup" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'conceptGroup.label', default: 'ConceptGroup')}" />
</head>

<body>

<section id="show-conceptGroup" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="conceptGroup.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: conceptGroupInstance, field: "name")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="conceptGroup.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${conceptGroupInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="conceptGroup.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${conceptGroupInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
<sec:access url="/conceptGroup/delete">
	<g:form action="delete">
		<g:hiddenField name="_method" value="DELETE" />
		<g:hiddenField name="id" value="${conceptGroupInstance.id}" />
		<g:submitButton class="btn btn-danger" name="delete" value="${message(code:'default.button.delete.label') }" /> 
	</g:form>
</sec:access>	

</section>

</body>

</html>