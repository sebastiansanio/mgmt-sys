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

	<g:select noSelection="${['':'Todas las cuentas']}" name="account" from="${mgmt.account.Account.list([sort:'code'])}" optionKey="id" value="" />
	<g:hiddenField name="Payment_date" value="${new Date().format('dd/MM/yyyy')}" />
	
	<g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.label')}" />

</g:form>

<h3>${message(code:'accountStatus.future.label')}</h3>
<h3>${message(code:'accountStatus.monthly.label')}</h3>

</section>

</body>

</html>