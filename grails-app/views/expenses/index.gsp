<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-accountStatus" class="first">
<h4><g:message code="menu.expenses.label" /></h4>
<div class="col-md-6">
<g:form onsubmit="checkFilters(event);" class="noblock" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('expenses')?.id}" >
<table class="col-md-6 table table-bordered">
	<tbody>
		<tr>
			<td><label for="Work_id"><g:message code="work.label"/> </label></td>
			<td><g:select class="select-chosen" noSelection="${['-1':'Todas las obras']}" name="Work_id" from="${mgmt.work.Work.list([sort:'code'])}" optionKey="id" value="" />
		</tr>
				<tr>
			<td><label for="Supplier_id"><g:message code="supplier.label"/> </label></td>
			<td><g:select class="select-chosen" noSelection="${['-1':'Todos los proveedores']}" name="Supplier_id" from="${mgmt.persons.Supplier.list([sort:'name'])}" optionKey="id" value="" />
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
			<td><label for="concepts"><g:message code="concepts.label"/> </label></td>
			<td>
				<select id="concepts" onchange="conceptsChanged();" name="concepts" >
					<option value="all">Todos</option>
					<option value="allM">Todos los GGI (M)</option>
					<option value="toM799">Todos los GGI hasta M799</option>
					<option value="fromM800">Todos los GGI desde M800</option>
				</select>
				<g:hiddenField name="Concept_code_from" /> 
				<g:hiddenField name="Concept_code_to" />
				
			</td>
		</tr>
		<tr>
			<td colspan="2"><g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.label')}" /></td>
		</tr>
	</tbody>
</table>
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
function conceptsChanged(){
	switch($("#concepts").val()){
	case 'all':
		$('#Concept_code_from').val('A000');
		$('#Concept_code_to').val('Z999');
		break;
	case 'allM':
		$('#Concept_code_from').val('M000');
		$('#Concept_code_to').val('M999');
		break;
	case 'toM799':
		$('#Concept_code_from').val('M000');
		$('#Concept_code_to').val('M799');
		break;
	case 'fromM800':
		$('#Concept_code_from').val('M800');
		$('#Concept_code_to').val('M999');
		break;
	}
}

function checkFilters(event){
	if($('#Work_id').val() == -1 && $('#Supplier_id').val() == -1 && $('#concepts').val() == 'all' && !$('#dateFromEnabled').prop('checked') && !$('#dateToEnabled').prop('checked') ){
		alert("Debe seleccionar al menos un filtro.");
		event.preventDefault();
	}
}

</script>

</body>

</html>