<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-supplierExpenses" class="first">
<h4><g:message code="menu.supplierExpenses.label" /></h4>
<div class="col-md-6">
<g:form onsubmit="checkFilters(event);" target="_blank" class="noblock" controller="supplierExpenses" action="download" id="${mgmt.reports.Report.findByCode('supplierExpenses').id}" >
<table class="col-md-6 table table-bordered">
	<tbody>
		<tr>
			<td><label for="Supplier_id"><g:message code="supplier.label"/> </label></td>
			<td><g:select class="select-chosen" noSelection="${['-1':'Todos los proveedores']}" name="Supplier_id" from="${mgmt.persons.Supplier.list([sort:'name'])}" optionValue="nameAndBusinessName" optionKey="id" value="" />
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
			<td><label for="Price_index_id"><g:message code="priceIndex.label"/> </label></td>
			<td><g:select class="select-chosen" noSelection="${['-1':'Ninguno']}" name="Price_index_id" from="${mgmt.index.PriceIndex.list(sort:'name')}" optionKey="id" optionValue="name" value="" />
		</tr>
		<tr>
			<td><g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.pdf.label')}" /></td>
			<td><g:actionSubmit class="btn btn-default" name="downloadExcel" action="downloadExcel" value="${message(code:'default.download.excel.label')}" /></td>
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

function checkFilters(event){
	if($('#Supplier_id').val() == -1 && !$('#dateFromEnabled').prop('checked') && !$('#dateToEnabled').prop('checked') ){
		alert("Debe seleccionar al menos un filtro.");
		event.preventDefault();
	}
}

</script>

</body>

</html>
