<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>

<section id="index-accountStatus" class="first">

<div class="col-md-6">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<g:sortableColumn class="center-aligned" property="name" title="${message(code: 'accountType.name.label', default: 'Name')}" />
				<th class="center-aligned"><g:message code="accountType.currentBalance.label" /></th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${accountTypeInstanceList}" status="i" var="accountTypeInstance">
			<g:set var="currentBalance" value="${balances[accountTypeInstance.id]}" />
			<g:if test="${currentBalance}" >
				<tr>
					<td><g:link action="show" id="${accountTypeInstance.id}">${fieldValue(bean: accountTypeInstance, field: "name")}</g:link></td>
					<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${currentBalance}"/></td>
				</tr>
			</g:if>
		</g:each>
		</tbody>
	</table>
</div>

</section>

</body>

</html>