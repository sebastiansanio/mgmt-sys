<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-accountStatus" class="first">

<div class="col-md-6">
<g:form class="noblock" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('balance').id}" >
<table class="col-md-6 table table-bordered">
	<tbody>
		<tr>
			<td><label for="Work_id"><g:message code="work.label"/> </label></td>
			<td><g:select class="select-chosen" noSelection="${['-1':'Todas las obras']}" name="Work_id" from="${mgmt.work.Work.list([sort:'code'])}" optionKey="id" value="" />
		</tr>
		<tr>
			<td><label for="account_id"><g:message code="default.dateFrom.label"/> </label></td>
			<td><bs:datePicker name="Date_from" precision="day" value="${new Date()}" /> <g:checkBox onchange="dateFromCheckboxChanged();" name="dateFromEnabled" value="true" /></td>
		</tr>
		<tr>
			<td><label for="account_id"><g:message code="default.dateTo.label"/> </label></td>
			<td><bs:datePicker name="Date_to" precision="day" value="${new Date()}" /> <g:checkBox onchange="dateToCheckboxChanged();" name="dateToEnabled" value="true" /> </td>
		</tr>
		<tr>
			<td colspan="2"><g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.label')}" /></td>
		</tr>
	</tbody>
</table>
<g:hiddenField name="Concept_code_from" value="A000" /> 
<g:hiddenField name="Concept_code_to" value="Z999" />
</g:form>
</div>

</section>

<script>
$(function() {
	$(".select-chosen").chosen({search_contains: true, width:'100%'});
	conceptsChanged();
});
function dateFromCheckboxChanged(){
	if($('#dateFromEnabled').prop( 'checked')){
		$("#Date_from").prop( "disabled", false);
	}else{
		$("#Date_from").prop( "disabled", true );
	} 
}
function dateToCheckboxChanged(){
	if($('#dateToEnabled').prop( 'checked')){
		$("#Date_to").prop( "disabled", false);
	}else{
		$("#Date_to").prop( "disabled", true );
	} 
}

</script>

</body>

</html>