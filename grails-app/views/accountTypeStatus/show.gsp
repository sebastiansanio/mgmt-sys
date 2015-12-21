
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

<div class="row">
<g:form action="search" method="get" >
<div class="col-md-3">
<label for="dateTo"><g:message code="default.date.label" /> </label>
<bs:datePicker class="form-control" name="dateTo" value="${params.dateTo}" />
<g:hiddenField name="id" value="${accountTypeInstance.id}" />
</div>
<div class="col-md-3">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.refresh.label')}" action="show" />
</div>
</g:form>
</div>


<table class="table table-bordered margin-top-medium">
	<thead>
		<tr>
			<g:sortableColumn class="center-aligned" property="name" title="${message(code: 'account.name.label')}" />
			<th class="center-aligned"><g:message code="account.currentBalance.label" /></th>
			<th class="center-aligned">Ver movimientos</th>
			<th class="center-aligned">Descargar movimientos</th>
		</tr>
	</thead>
	<tbody>
	<g:each in="${accountTypeInstance.accounts.sort{it.name}}" status="i" var="account">
		<g:set var="currentBalance" value="${balances[account.id]}" />
		<g:if test="${currentBalance}" >
			<tr>
				<td>${fieldValue(bean: account, field: "name")}</td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${currentBalance}"/></td>
				<td class="center-aligned"><g:link action="showPayments" id="${account.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td class="center-aligned"><g:link action="download" id="${account.id}"><span class="glyphicon glyphicon-download"></span></g:link></td>
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