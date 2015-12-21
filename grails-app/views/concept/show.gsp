
<%@ page import="mgmt.concept.Concept" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'concept.label', default: 'Concept')}" />
</head>

<body>

<section id="show-concept" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: conceptInstance, field: "code")}</td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.description.label" default="Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: conceptInstance, field: "description")}</td>
				
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.conceptGroup.label" default="Concept Group" /></td>
				
				<td valign="top" class="value"><g:link controller="conceptGroup" action="show" id="${conceptInstance?.conceptGroup?.id}">${conceptInstance?.conceptGroup?.encodeAsHTML()}</g:link></td>
				
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.conceptAccount.label" default="Concept Account" /></td>
				
				<td valign="top" class="value"><g:link controller="conceptAccount" action="show" id="${conceptInstance?.conceptAccount?.id}">${conceptInstance?.conceptAccount?.encodeAsHTML()}</g:link></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.validInFiWork.label" default="Valid In Fi Work" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${conceptInstance?.validInFiWork}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.validInInNoWork.label" default="Valid In In No Work" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${conceptInstance?.validInInNoWork}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.validInInWork.label" default="Valid In In Work" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${conceptInstance?.validInInWork}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.validInOpNoWork.label" default="Valid In Op No Work" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${conceptInstance?.validInOpNoWork}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.validInOpWork.label" default="Valid In Op Work" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${conceptInstance?.validInOpWork}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.validInOsNoWork.label" default="Valid In Os No Work" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${conceptInstance?.validInOsNoWork}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.validInOsWork.label" default="Valid In Os Work" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${conceptInstance?.validInOsWork}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${conceptInstance?.dateCreated}" /></td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${conceptInstance?.lastUpdated}" /></td>
				
			</tr>
		</tbody>
	</table>
<sec:access url="/concept/delete">
<g:if test="${!conceptInstance.movements}">
	<g:form action="delete">
		<g:hiddenField name="_method" value="DELETE" />
		<g:hiddenField name="id" value="${conceptInstance.id}" />
		<g:submitButton onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger" name="delete" value="${message(code:'default.button.delete.label') }" /> 
	</g:form>
</g:if>
</sec:access>
</section>
</body>

</html>