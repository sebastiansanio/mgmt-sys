<%@ page import="mgmt.account.AccountType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountType.label', default: 'AccountType')}" />
</head>

<body>

<section id="index-accountType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn  class="center-aligned" property="name" title="${message(code: 'accountType.name.label', default: 'Name')}" />
				<g:sortableColumn class="center-aligned" property="dateCreated" title="${message(code: 'account.dateCreated.label')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${accountTypeInstanceList}" status="i" var="accountTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${accountTypeInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: accountTypeInstance, field: "name")}</td>
				<td class="center-aligned"><g:formatDate date="${accountTypeInstance.dateCreated}"/></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${accountTypeInstanceCount}" />
	</div>
</section>

</body>

</html>