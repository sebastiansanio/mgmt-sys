
<%@ page import="mgmt.security.SecAuthority" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'secAuthority.label', default: 'SecAuthority')}" />
</head>

<body>

<section id="index-secAuthority" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.edit.label')}</th>
				<g:sortableColumn property="authority" title="${message(code: 'secAuthority.authority.label', default: 'Authority')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${secAuthorityInstanceList}" status="i" var="secAuthorityInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${secAuthorityInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: secAuthorityInstance, field: "authority")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${secAuthorityInstanceCount}" />
	</div>
</section>

</body>

</html>