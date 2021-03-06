
<%@ page import="mgmt.account.Account" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
</head>

<body>

<section id="show-account" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="account.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: accountInstance, field: "code")}</td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="account.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: accountInstance, field: "name")}</td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="account.type.label" default="Type" /></td>
				
				<td valign="top" class="value"><g:link controller="accountType" action="show" id="${accountInstance?.type?.id}">${accountInstance?.type?.encodeAsHTML()}</g:link></td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="account.currentBalance.label" /></td>
				
				<td valign="top" class="value">${accountInstance.currentBalance}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="account.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${accountInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="account.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${accountInstance?.lastUpdated}" /></td>
				
			</tr>
		</tbody>
	</table>

<sec:access url="/account/delete">
<g:if test="${!accountInstance.payments}">
	<g:form action="delete">
		<g:hiddenField name="_method" value="DELETE" />
		<g:hiddenField name="id" value="${accountInstance.id}" />
		<g:submitButton onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger" name="delete" value="${message(code:'default.button.delete.label') }" /> 
	</g:form>
</g:if>
</sec:access>
</section>

</body>

</html>