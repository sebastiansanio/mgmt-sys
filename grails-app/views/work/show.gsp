
<%@ page import="mgmt.work.Work" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
</head>

<body>

<section id="show-work" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: workInstance, field: "name")}</td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: workInstance, field: "code")}</td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.type.label" default="Type" /></td>
				
				<td valign="top" class="value">${message(code:'work.type.'+ workInstance.type)}</td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.finished.label" default="Finished" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${workInstance?.finished}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.client.label" default="Client" /></td>
				
				<td valign="top" class="value"><g:link controller="client" action="show" id="${workInstance?.client?.id}">${workInstance?.client?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.budget.label" default="Budget" /></td>
				
				<td valign="top" class="value"><g:link controller="budget" action="show" id="${workInstance?.budget?.id}">${workInstance?.budget?.encodeAsHTML()}</g:link></td>
				
			</tr>

		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${workInstance?.dateCreated}" /></td>
				
			</tr>
		

		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="work.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${workInstance?.lastUpdated}" /></td>
				
			</tr>
		

		
		</tbody>
	</table>
	<g:if test="${!workInstance.finished}">
		<sec:access url="/work/close">
			<g:form action="close">
				<g:hiddenField name="id" value="${workInstance.id}" />
				<g:submitButton class="btn btn-warning" name="close" value="${message(code:'work.close.label') }" /> 
			</g:form>
		</sec:access>
	</g:if>
	<g:else>
		<sec:access url="/work/open">
			<g:form action="open">
				<g:hiddenField name="id" value="${workInstance.id}" />
				<g:submitButton class="btn btn-primary" name="open" value="${message(code:'work.open.label') }" /> 
			</g:form>
		</sec:access>
	</g:else>
	
</section>

</body>

</html>