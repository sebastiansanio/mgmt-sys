<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-accountStatus" class="first">

<div class="col-md-6">
<g:form class="noblock" target="_blank" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('accountStatus').id}" >
<table class="table table-bordered">
	<thead>
		<tr>
			<th colspan="2"><h3>${message(code:'accountStatus.current.label')}</h3></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><label for="account_id"><g:message code="account.label"/> </label></td>
			<td><g:select noSelection="${['':'Todas las cuentas']}" name="account_id" from="${mgmt.account.Account.list([sort:'code'])}" optionKey="id" value="" />
			<g:hiddenField name="Payment_date" value="${new Date().format('dd/MM/yyyy')}" /></td>
		</tr>
		<tr>
			<td colspan="2"><g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.label')}" /></td>
		</tr>
	</tbody>
</table>
</g:form>
</div>

<div class="col-md-6">
<g:form class="noblock" target="_blank" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('accountStatus').id}" >
<table class="col-md-6 table table-bordered">
	<thead>
		<tr>
			<th colspan="2"><h3>${message(code:'accountStatus.future.label')}</h3></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><label for="account_id"><g:message code="account.label"/> </label></td>
			<td><g:select noSelection="${['':'Todas las cuentas']}" name="account_id" from="${mgmt.account.Account.list([sort:'code'])}" optionKey="id" value="" />
			</td>
		</tr>
		<tr>
			<td><label for="Payment_date"><g:message code="payment.paymentDate.label"/> </label></td>
			<td><bs:datePicker name="Payment_date" precision="day" value="${new Date()}" /></td>
		</tr>	
		<tr>
			<td colspan="2"><g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.label')}" /></td>
		</tr>
	</tbody>
</table>
</g:form>
</div>

</section>

</body>

</html>