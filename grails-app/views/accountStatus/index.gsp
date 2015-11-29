<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-accountStatus" class="first">

<h3>${message(code:'accountStatus.current.label')}</h3>

<g:form class="noblock" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('accountStatus').id}" >
<div class="row">
	<label for="account_id"><g:message code="account.label"/> </label>
	<g:select noSelection="${['':'Todas las cuentas']}" name="account_id" from="${mgmt.account.Account.list([sort:'code'])}" optionKey="id" value="" />
	<g:hiddenField name="Payment_date" value="${new Date().format('dd/MM/yyyy')}" />
</div>
<div class="row">
	<g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.label')}" />
</div>
</g:form>

<h3>${message(code:'accountStatus.future.label')}</h3>

<g:form class="noblock" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('accountStatus').id}" >
<div class="row">
	<label for="account_id"><g:message code="account.label"/> </label>
	<g:select noSelection="${['':'Todas las cuentas']}" name="account_id" from="${mgmt.account.Account.list([sort:'code'])}" optionKey="id" value="" />
</div>
<div class="row">
	<label for="Payment_date"><g:message code="payment.paymentDate.label"/> </label>
	<bs:datePicker name="Payment_date" precision="day" value="${new Date()}" />
</div>
<div class="row">
	<g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.label')}" />
</div>
</g:form>


</section>

</body>

</html>