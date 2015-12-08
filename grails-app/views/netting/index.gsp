<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-accountStatus" class="first">
<h4><g:message code="menu.netting.label" /></h4>

<div class="col-md-6">
<g:form class="noblock" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('netting')?.id}" >
<table class="col-md-6 table table-bordered">
	<tbody>
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