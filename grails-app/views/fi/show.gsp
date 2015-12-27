
<%@ page import="mgmt.movement.Movement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'movement.label', default: 'Movement')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>
<section id="show-movement" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.type.label" default="Type" /></td>
				
				<td valign="top" class="value"><g:message code="movement.type.${movementInstance.type}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.number.label" default="Number" /></td>
				
				<td valign="top" class="value">${movementInstance.number}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.year.label" /></td>
				
				<td valign="top" class="value">${movementInstance.year}</td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.checked.label" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${movementInstance.checked}" /></td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.amount.label" /></td>
				
				<td valign="top" class="value">${movementInstance.amount}</td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.note.label" /></td>
				
				<td valign="top" class="value">${movementInstance.note}</td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${movementInstance?.dateCreated}" /></td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="movement.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${movementInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
	
	<g:if test="${!movementInstance.checked}">
		<sec:access url="/fi/check">
			<g:form action="check">
				<g:hiddenField name="id" value="${movementInstance.id}" />
				<g:submitButton class="btn btn-primary" name="check" value="${message(code:'movement.check.label') }" /> 
			</g:form>
		</sec:access>
	</g:if>
	<g:else>
		<sec:access url="/fi/uncheck">
			<g:form action="uncheck">
				<g:hiddenField name="id" value="${movementInstance.id}" />
				<g:submitButton class="btn btn-warning" name="uncheck" value="${message(code:'movement.uncheck.label') }" /> 
			</g:form>
		</sec:access>
	</g:else>
	<sec:access url="/op/delete">
	<g:form action="delete">
		<g:hiddenField name="_method" value="DELETE" />
		<g:hiddenField name="id" value="${movementInstance.id}" />
		<g:submitButton onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger margin-top-medium" name="delete" value="${message(code:'default.button.delete.label') }" /> 
	</g:form>
	</sec:access>	
	
</section>

</body>

</html>