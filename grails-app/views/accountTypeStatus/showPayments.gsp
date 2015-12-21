
<%@ page import="mgmt.account.AccountType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountType.label', default: 'AccountType')}" />
</head>

<body>

<section id="show-accountType" class="first">

<div class="col-md-9">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code: 'payment.account.label')}</th>
				<th class="center-aligned">${message(code: 'payment.movement.label')} </th>
				<th class="center-aligned">${message(code: 'payment.paymentDate.label')} </th>
				<th class="center-aligned">${message(code: 'payment.checkNumber.label')} </th>
				<th class="center-aligned">${message(code: 'payment.amount.label')} </th>
				<th class="center-aligned">${message(code: 'payment.note.label')} </th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${payments}" status="i" var="payment">
			<tr>
				<td>${payment.account}</td>
				<td>${payment.movement}</td>
				<td><g:formatDate date="${payment.paymentDate}" format="dd/MM/yyyy" /></td>
				<td>${payment.checkNumber}</td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${payment.amount*payment.multiplier}"/></td>
				<td>${payment.note}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${paymentsCount}" params="${params}" />
	</div>
</div>


<g:link class="btn btn-default" action="show" id="${account.type.id}" ><g:message code="default.return.label"/> </g:link>

</section>

</body>

</html>