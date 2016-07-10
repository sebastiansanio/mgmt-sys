<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>

<section id="index-accountStatus" class="first">
<h4><g:message code="menu.income.label" /></h4>
<div class="col-md-6">
<g:form onsubmit="validateForm(event);" target="_blank" class="noblock" controller="income" action="download" id="${mgmt.reports.Report.findByCode('income').id}" >
<table class="col-md-6 table table-bordered">
	<tbody>
		<tr>
			<td><label for="Work_id"><g:message code="work.label"/> </label></td>
			<td><g:select class="select-chosen" noSelection="${['-1':'GG']}" name="Work_id" from="${new ArrayList([[id:-2,codeAndName:'Todas las obras']]).plus(mgmt.work.Work.list([sort:['type':'desc','code':'desc']]))}" optionKey="id" value="" optionValue="codeAndName" />
		</tr>
		<tr>
			<td><label for="account_id"><g:message code="default.dateFrom.label"/> </label></td>
			<td><bs:datePicker name="Date_from" precision="day" value="${new Date()}" /> <g:checkBox onchange="dateFromCheckboxChanged();" name="dateFromEnabled" checked="false" /></td>
		</tr>
		<tr>
			<td><label for="account_id"><g:message code="default.dateTo.label"/> </label></td>
			<td><bs:datePicker name="Date_to" precision="day" value="${new Date()}" /> <g:checkBox onchange="dateToCheckboxChanged();" name="dateToEnabled" checked="false" /> </td>
		</tr>
		<tr>
			<td colspan="2">
			
				<g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.pdf.label')}" />
			</td>
		</tr>
	</tbody>
</table>
</g:form>
</div>

</section>

<script>
$(function() {
	$(".select-chosen").chosen({search_contains: true, width:'100%'});
	dateFromCheckboxChanged();
	dateToCheckboxChanged();
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

function validateForm(event){
	if($('#Work_id').val() == -2 && !$('#dateFromEnabled').is(':checked')
			&& !$('#dateToEnabled').is(':checked')){
		alert("Debe seleccionar al menos un filtro");
		event.preventDefault();
	}
}

</script>

</body>

</html>