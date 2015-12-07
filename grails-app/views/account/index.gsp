
<%@ page import="mgmt.account.Account" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
</head>

<body>

<section id="index-account" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="code" title="${message(code: 'account.code.label', default: 'Code')}" />
			
				<g:sortableColumn property="name" title="${message(code: 'account.name.label', default: 'Name')}" />

				<g:sortableColumn property="type.name" title="${message(code: 'account.type.label')}" />
			
				<th><g:message code="account.currentBalance.label" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${accountInstanceList}" status="i" var="accountInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${accountInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: accountInstance, field: "code")}</td>
			
				<td>${fieldValue(bean: accountInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: accountInstance, field: "type")}</td>
			
				<td><g:formatNumber format="###,##0.##" number="${accountInstance.currentBalance}" /></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${accountInstanceCount}" />
	</div>
</section>

</body>

</html>