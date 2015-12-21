
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
				<th class="center-aligned">${message(code:'default.show.label')}</th>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" property="code" title="${message(code: 'account.code.label', default: 'Code')}" />
				<g:sortableColumn class="center-aligned" property="name" title="${message(code: 'account.name.label', default: 'Name')}" />
				<g:sortableColumn class="center-aligned" property="type.name" title="${message(code: 'account.type.label')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${accountInstanceList}" status="i" var="accountInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="show" id="${accountInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td class="center-aligned"><g:link action="edit" id="${accountInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: accountInstance, field: "code")}</td>
				<td>${fieldValue(bean: accountInstance, field: "name")}</td>
				<td>${fieldValue(bean: accountInstance, field: "type")}</td>
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