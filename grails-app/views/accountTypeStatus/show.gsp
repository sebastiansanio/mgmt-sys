
<%@ page import="mgmt.account.AccountType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountType.label', default: 'AccountType')}" />
</head>

<body>

<section id="show-accountType" class="first">

<div class="col-md-6">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<g:sortableColumn property="name" title="${message(code: 'account.name.label')}" />
				<th><g:message code="account.currentBalance.label" /></th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${accountTypeInstance.accounts.sort{it.name}}" status="i" var="account">
			<g:set var="currentBalance" value="${account.currentBalance}" />
			<g:if test="${currentBalance}" >
				<tr>
					<td><g:link action="download" id="${account.id}">${fieldValue(bean: account, field: "name")}</g:link></td>
					<td><g:formatNumber format="###,##0.##" number="${currentBalance}"/></td>
				</tr>
			</g:if>
		</g:each>
		</tbody>
	</table>
</div>


<g:link class="btn btn-default" action="index" ><g:message code="default.return.label"/> </g:link>

</section>

</body>

</html>