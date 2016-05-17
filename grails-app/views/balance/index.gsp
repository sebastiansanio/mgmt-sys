<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-accountStatus" class="first">

<div class="col-md-4">
<g:form class="noblock" target="_blank" method="get" action="show"  >
<table class="col-md-6 table table-bordered">
	<tbody>
		<tr>
			<td><label for="id"><g:message code="work.label"/> </label></td>
			<td><g:select class="select-chosen" name="workId" from="${mgmt.work.Work.list([sort:'code'])}" optionKey="id" value="" />
		</tr>
		<tr>
			<td><g:submitButton class="btn btn-default" name="show" value="${message(code:'default.show.label')}" /></td>
			<td><g:hiddenField name="id" value="${mgmt.reports.Report.findByCode('workBalance').id}"/> <g:actionSubmit class="btn btn-default" name="download" action="download" value="${message(code:'default.download.pdf.label')}" /></td>
		</tr>
	</tbody>
</table>
</g:form>
</div>

</section>

<script>
$(function() {
	$(".select-chosen").chosen({search_contains: true, width:'100%'});
});

</script>

</body>

</html>