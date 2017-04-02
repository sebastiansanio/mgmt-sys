
<%@ page import="mgmt.account.AccountType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountType.label', default: 'AccountType')}" />
</head>

<body>

<section id="show-accountType" class="first">



<div class="row">
<div class="col-md-6">
<div class="col-md-3">
<g:form action="show" method="get" >
<label for="balanceDate"><g:message code="account.balanceDate.label" /> </label>
<bs:datePicker class="form-control" name="balanceDate" value="${params.balanceDate}" />
<g:hiddenField name="id" value="${params.id}" />
<g:actionSubmit class="btn btn-default margin-top-medium" value="${message(code:'default.refresh.label')}" action="show" />
</g:form>
</div>
</div>
</div>

<div class="col-md-6">
<table class="table table-bordered margin-top-medium">
	<thead>
		<tr>
			<g:sortableColumn class="center-aligned" property="name" title="${message(code: 'account.name.label')}" />
			<th class="center-aligned"><g:message code="account.balance.label" /></th>
			<th class="center-aligned">Ver movimientos</th>
			<th class="center-aligned">Descargar movimientos</th>
		</tr>
	</thead>
	<tbody>
	<g:each in="${accounts}" status="i" var="account">
		<g:set var="currentBalance" value="${balances[account.id]}" />

		<tr>
			<td>${fieldValue(bean: account, field: "name")}</td>
			<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${currentBalance?:0}"/></td>
			<td class="center-aligned"><g:form class="noblock" action="showPayments" target="_blank" method="get" id="${account.id}" > <button onclick="setFilterDates('showPayments-${account.id}');" type="submit" >  <g:hiddenField name="dateFrom" id="dateFrom-showPayments-${account.id}" /> <g:hiddenField name="dateTo" id="dateTo-showPayments-${account.id}" />   <span class="glyphicon glyphicon-eye-open"></span></button> </g:form></td>
			<td class="center-aligned"><g:form class="noblock" action="download" method="get" id="${account.id}"> <button onclick="setFilterDates('download-${account.id}');" type="submit" > <g:hiddenField name="dateFrom" id="dateFrom-download-${account.id}" /> <g:hiddenField name="dateTo" id="dateTo-download-${account.id}" /> <span class="glyphicon glyphicon-download"></span></button> </g:form></td>
		</tr>

	</g:each>
	</tbody>
</table>
</div>

<div class="col-md-6">

<div class="col-md-12">
<g:link class="btn btn-default" action="index" ><g:message code="default.return.label"/> </g:link>
</div>

<div class="col-md-12">
<div class="col-md-3">
<label for="dateFrom"><g:message code="default.dateFrom.label"/> </label>
<bs:datePicker class="form-control" name="dateFrom" precision="day" value="${new Date()}" /> 
<g:checkBox onchange="dateFromCheckboxChanged();" name="dateFromEnabled" value="${false}" />
</div>
</div>

<div class="col-md-12">
<div class="col-md-3">
<label for="dateTo"><g:message code="default.dateTo.label"/> </label>
<bs:datePicker class="form-control" name="dateTo" precision="day" value="${new Date()}" /> 
<g:checkBox onchange="dateToCheckboxChanged();" name="dateToEnabled" value="${false}" />
</div>
</div>


</div>


</section>



<script>
$(function() {
	dateFromCheckboxChanged();
	dateToCheckboxChanged();
});

function dateFromCheckboxChanged(){
	if($('#dateFromEnabled').prop( 'checked')){
		$("#dateFrom").prop( "disabled", false);
	}else{
		$("#dateFrom").prop( "disabled", true );
	} 
}
function dateToCheckboxChanged(){
	if($('#dateToEnabled').prop( 'checked')){
		$("#dateTo").prop( "disabled", false);
	}else{
		$("#dateTo").prop( "disabled", true );
	} 
}
function setFilterDates(suffix){
	if($("#dateFrom").prop( "disabled")==false){
		$("#dateFrom-"+suffix).val($("#dateFrom").val());
	}
	if($("#dateTo").prop( "disabled")==false){
		$("#dateTo-"+suffix).val($("#dateTo").val());
	}

}

</script>

</body>

</html>