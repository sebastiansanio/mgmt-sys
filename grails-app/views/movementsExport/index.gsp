<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>

<section id="index-accountStatus" class="first">
<h4><g:message code="menu.movementsExport.label" /></h4>
<div class="col-md-6">
<g:form class="noblock" controller="movementsExport" action="download"  >
<table class="col-md-6 table table-bordered">
	<tbody>
		<tr>
			<td><label for="Work_id"><g:message code="work.label"/> </label></td>
			<td><g:select onchange="refreshConcepts();" class="select-chosen" noSelection="${['-1':'GG']}" name="Work_id" from="${new ArrayList([[id:-2,codeAndName:'Todas las obras']]).plus(mgmt.work.Work.list([sort:['type':'desc','code':'desc']]))}" optionKey="id" optionValue="codeAndName" value="" />
		</tr>
		<tr>
			<td><label for="Date_from"><g:message code="default.dateFrom.label"/> </label></td>
			<td><bs:datePicker name="Date_from" precision="day" value="${new Date()}" /> <g:checkBox onchange="dateFromCheckboxChanged();" name="dateFromEnabled" checked="false" /></td>
		</tr>
		<tr>
			<td><label for="Date_to"><g:message code="default.dateTo.label"/> </label></td>
			<td><bs:datePicker name="Date_to" precision="day" value="${new Date()}" /> <g:checkBox onchange="dateToCheckboxChanged();" name="dateToEnabled" checked="false" /> </td>
		</tr>
		
		<tr>
			<td><label for="Price_index_id"><g:message code="priceIndex.label"/> </label></td>
			<td><g:select class="select-chosen" noSelection="${['-1':'Ninguno']}" name="Price_index_id" from="${mgmt.index.PriceIndex.list(sort:'name')}" optionKey="id" optionValue="name" value="" />
		</tr>
		
		<tr id="trConcepts">
			<td><label for="concepts"><g:message code="concepts.label"/> </label></td>
			<td>
				<select id="concepts" name="concepts" >
					<option value="all">Todos</option>
					<option value="toM799">Todos los GGI hasta M y P799</option>
					<option value="fromM800">Todos los GGI desde M y P800</option>
				</select>
			</td>
		</tr>

		<tr>
			<td colspan="2">
				<g:actionSubmit class="btn btn-default" action="downloadExcel" value="Descargar Excel" />			
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
	refreshConcepts();
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

function refreshConcepts(){
	if($("#Work_id").val() == -1 ){
		$("#trConcepts").show();
	}else{
		$("#trConcepts").hide();
	}
}

</script>

</body>

</html>