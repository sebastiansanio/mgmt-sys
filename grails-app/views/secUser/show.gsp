
<%@ page import="mgmt.security.SecUser" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'secUser.label', default: 'SecUser')}" />
</head>

<body>

<section id="show-secUser" class="first">

	<table class="table">
		<tbody>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: secUserInstance, field: "name")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.username.label" default="Username" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: secUserInstance, field: "username")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.accountExpired.label" default="Account Expired" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${secUserInstance?.accountExpired}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.accountLocked.label" default="Account Locked" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${secUserInstance?.accountLocked}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.enabled.label" default="Enabled" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${secUserInstance?.enabled}" /></td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.passwordExpired.label" default="Password Expired" /></td>
				
				<td valign="top" class="value"><g:formatBoolean boolean="${secUserInstance?.passwordExpired}" /></td>
				
			</tr>
		
				
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${secUserInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secUser.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${secUserInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>