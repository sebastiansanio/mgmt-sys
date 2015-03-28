
<%@ page import="mgmt.security.SecUser" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'secUser.label', default: 'SecUser')}" />
</head>

<body>

<section id="index-secUser" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>

				<g:sortableColumn property="name" title="${message(code: 'secUser.name.label', default: 'Name')}" />
			
				<g:sortableColumn property="username" title="${message(code: 'secUser.username.label', default: 'Username')}" />
			
				<g:sortableColumn property="accountExpired" title="${message(code: 'secUser.accountExpired.label', default: 'Account Expired')}" />
			
				<g:sortableColumn property="accountLocked" title="${message(code: 'secUser.accountLocked.label', default: 'Account Locked')}" />
			
				<g:sortableColumn property="enabled" title="${message(code: 'secUser.enabled.label', default: 'Enabled')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${secUserInstanceList}" status="i" var="secUserInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${secUserInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: secUserInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: secUserInstance, field: "username")}</td>
			
				<td><g:formatBoolean boolean="${secUserInstance.accountExpired}" /></td>
			
				<td><g:formatBoolean boolean="${secUserInstance.accountLocked}" /></td>
			
				<td><g:formatBoolean boolean="${secUserInstance.enabled}" /></td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${secUserInstanceCount}" />
	</div>
</section>

</body>

</html>