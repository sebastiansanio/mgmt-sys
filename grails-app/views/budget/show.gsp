<%@ page import="mgmt.work.Budget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
</head>

<body>
<%@ page import="mgmt.work.Budget" %>

<div class="col-md-4 ${hasErrors(bean: budgetInstance, field: 'name', 'has-error')} ">
	<label for="name" class="control-label"><g:message code="budget.name.label" default="Name" /> <span class="required-indicator">*</span> </label>
	<div>
		<g:textField required="" class="form-control" name="name" value="${budgetInstance?.name}"/>
	</div>
</div>

<div class="col-md-4 ${hasErrors(bean: budgetInstance, field: 'client', 'has-error')} ">
	<label for="client" class="control-label"><g:message code="budget.client.label" default="Client" /></label>
	<div>
		<g:select class="form-control" id="client" name="client.id" from="${mgmt.persons.Client.list()}" optionKey="id" value="${budgetInstance?.client?.id}" noSelection="['null': '']"/>
	</div>
</div>



<div class="col-md-9" >	
<h4><g:message code="budget.items.label" /></h4>
<div id="items" class="table-responsive">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th>${message(code: 'budgetItem.concept.label')}</th>
				<th>${message(code: 'budgetItem.amount.label')}</th>
				<th>${message(code: 'budget.percentageOfDirectCosts.label')}</th>
				<th>${message(code: 'budget.percentageOfSellPrice.label')}</th>
			</tr>
		</thead>
		<tbody id="items-table">
			<g:each var="budgetItemInstance" in="${budgetInstance.items}" status="i">
				<tr class="form-inline" id="items-${i}">
					<td class="td-intableform"><g:select class="input-intableform form-control" id="concept-${i}" name="items[${i}].concept.id" from="${mgmt.concept.Concept.findAllByCodeLike('L%')}" optionKey="id" required="" value="${budgetItemInstance.concept.id}"/></td>
					<td class="td-intableform"><g:field onchange="calculateBudget();" type="text" class="input-intableform form-control right-aligned field-item-amount" name="items[${i}].amount" id="amount-${i}" value="${budgetItemInstance.amount}" required=""/></td>
					<td class="td-intableform"><g:field readonly="true" tabindex="-1" type="text" class="input-intableform form-control right-aligned readonly" name="items[${i}].percentageOfDirectCosts" id="percentageOfDirectCosts-${i}" value=""/></td>
					<td class="td-intableform"><g:field readonly="true" tabindex="-1" type="text" class="input-intableform form-control right-aligned readonly" name="items[${i}].percentageOfSellPrice" id="percentageOfSellPrice-${i}" value=""/></td>
				</tr>
			</g:each>
		</tbody>
	</table>
</div>

<table >
	<thead>
		<tr>
			<th class="center-aligned">${message(code: 'budget.item.label')}</th>
			<th class="center-aligned">${message(code: 'budget.amount.label')}</th>
			<th class="center-aligned">${message(code: 'budget.percentageOfDirectCosts.label')}</th>
			<th class="center-aligned">${message(code: 'budget.percentageOfSellPrice.label')}</th>
			<th class="center-aligned">${message(code: 'budget.amount.label')}</th>
			<th class="center-aligned">${message(code: 'budget.percentage.label')}</th>
		</tr>
	</thead>
	<tbody>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'directCosts', 'has-error')} required">
			<td class="td-intableform"><g:message code="budget.directCosts.label" /></td>
			<td class="td-intableform"><g:field onchange="calculateBudget();" type="text" class="right-aligned form-control" name="directCosts" value="${budgetInstance.directCosts}" required=""/></td>
			<td class="td-intableform"><g:field type="text" readonly="true" tabindex="-1" class="right-aligned form-control readonly" name="directCostsPercentageOfDirectCosts" value="" required=""/></td>
			<td class="td-intableform"><g:field type="text" readonly="true" tabindex="-1" class="right-aligned form-control readonly" name="directCostsPercentageOfSellPrice" value="" required=""/></td>

		</tr>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'iibbAmount', 'has-error')} ${hasErrors(bean: budgetInstance, field: 'iibbPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.iibbPercentage.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="iibbCalculatedAmount" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="iibbPercentageOfDirectCosts" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="iibbPercentageOfSellPrice" value="" /></td>
			<td><g:field onchange="\$('#iibbPercentage').val(0); calculateBudget();" type="text" class="right-aligned form-control" name="iibbAmount" value="${budgetInstance.iibbAmount}" required=""/></td>
			<td><g:field onchange="\$('#iibbAmount').val(0); calculateBudget();" type="text" class="right-aligned form-control" name="iibbPercentage" value="${budgetInstance.iibbPercentage}" required=""/></td>

		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="budget.ggo.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggo" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggoPercentageOfDirectCosts" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggoPercentageOfSellPrice" value="" /></td>

		</tr>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'indirectOverheadAmount', 'has-error')} ${hasErrors(bean: budgetInstance, field: 'indirectOverheadPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.indirectOverheadPercentage.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="indirectOverheadCalculatedAmount" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="indirectOverheadCalculatedAmountPercentageOfDirectCosts" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="indirectOverheadCalculatedAmountPercentageOfSellPrice" value=""/></td>
			<td><g:field onchange="\$('#indirectOverheadPercentage').val(0); calculateBudget();" type="text" class="right-aligned form-control" name="indirectOverheadAmount" value="${budgetInstance.indirectOverheadAmount}" required=""/></td>
			<td><g:field onchange="\$('#indirectOverheadAmount').val(0); calculateBudget();" type="text" class="right-aligned form-control" name="indirectOverheadPercentage" value="${budgetInstance.indirectOverheadPercentage}" required=""/></td>

		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="budget.gg.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="gg" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggPercentageOfDirectCosts" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggPercentageOfSellPrice" value="" /></td>

		</tr>

		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'profitPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.profitPercentage.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="profitCalculatedAmount" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="profitPercentageOfDirectCosts" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="profitPercentageOfSellPrice" value=""/></td>
			<td><g:field onchange="\$('#profitPercentage').val(0); calculateBudget();" type="text" class="right-aligned form-control" name="profitAmount" value="${budgetInstance.profitAmount}" required=""/></td>
			<td><g:field onchange="\$('#profitAmount').val(0); calculateBudget();" type="text" class="right-aligned form-control" name="profitPercentage" value="${budgetInstance.profitPercentage}" required=""/></td>

		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="budget.ggb.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggb" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggbPercentageOfDirectCosts" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ggbPercentageOfSellPrice" value="" /></td>

		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="budget.pvai.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="pvai" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="pvaiPercentageOfDirectCosts" value=""/></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="pvaiPercentageOfSellPrice" value="" /></td>
		</tr>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'ivaPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.ivaPercentage.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="ivaCalculatedAmount" value=""/></td>
			<td></td>
			<td></td>
			<td></td>
			<td><g:field onchange="calculateBudget();" type="text" class="right-aligned form-control" name="ivaPercentage" value="${budgetInstance.ivaPercentage?:21}" required=""/></td>
		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="budget.pvii.label" /></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="pvii" value=""/></td>
		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="budget.cp.label" /></td>
			<td></td>
			<td><g:field readonly="true" tabindex="-1" type="text" class="right-aligned form-control readonly" name="cp" value=""/></td>
		</tr>

	</tbody>
</table>

<g:if test="${!budgetInstance.hasWork}">
	<g:form action="generateWork" id="${budgetInstance.id}">
		<g:submitButton onclick="confirmGenerateWork(event);" class="btn btn-primary" name="generateWork" value="${message(code:'work.generateWork.message')}" />
	</g:form>
</g:if>

</div>


<script>

function confirmGenerateWork(event){
	if(!confirm("${message(code:'work.generateWork.confirm.message')}")){
		event.preventDefault();
	}
}

var itemsQuantity = ${budgetInstance.items?.size()?:0};
	
function calculateBudget(){
	if(!$.isNumeric($("#directCosts").val()) || $("#directCosts").val() <= 0){
		return;
	}
	var directCosts = parseFloat($("#directCosts").val());

	var itemsTotal = 0;
	$(".field-item-amount").each(function() {
		itemsTotal += Number($(this).val());
	});
	
	var totalCosts = directCosts + itemsTotal + parseFloat($("#iibbAmount").val()) + parseFloat($("#indirectOverheadAmount").val()) + parseFloat($("#profitAmount").val());

	var pvai = totalCosts / (1 - parseFloat($("#iibbPercentage").val())/100 - parseFloat($("#indirectOverheadPercentage").val())/100 - parseFloat($("#profitPercentage").val())/100 );
	$("#pvai").val(pvai.toFixed(2));

	var iibb = parseFloat($("#iibbAmount").val()) != 0 ? parseFloat($("#iibbAmount").val()) : pvai * parseFloat($("#iibbPercentage").val())/100
	$("#iibbCalculatedAmount").val(iibb.toFixed(2));

	var ggo = itemsTotal + iibb;
	$("#ggo").val(ggo.toFixed(2));

	var indirectOverhead = parseFloat($("#indirectOverheadAmount").val()) != 0 ? parseFloat($("#indirectOverheadAmount").val()) : pvai * parseFloat($("#indirectOverheadPercentage").val())/100
	$("#indirectOverheadCalculatedAmount").val(indirectOverhead.toFixed(2));

	var gg = ggo + indirectOverhead;
	$("#gg").val(gg.toFixed(2));

	var profit = parseFloat($("#profitAmount").val()) != 0 ? parseFloat($("#profitAmount").val()) : pvai * parseFloat($("#profitPercentage").val())/100
	$("#profitCalculatedAmount").val(profit.toFixed(2));

	var ggb = gg + profit;
	$("#ggb").val(ggb.toFixed(2));

	var iva = pvai * parseFloat($("#ivaPercentage").val())/100;
	$("#ivaCalculatedAmount").val(iva.toFixed(2));

	var pvii = pvai + iva;
	$("#pvii").val(pvii.toFixed(2));

	var cp = pvai/directCosts;
	$("#cp").val(cp.toFixed(2));
	
	$("#directCostsPercentageOfDirectCosts").val((100 * directCosts / directCosts).toFixed(2));
	$("#directCostsPercentageOfSellPrice").val((100 * directCosts / pvai).toFixed(2));

	$("#iibbPercentageOfDirectCosts").val((100 * iibb / directCosts).toFixed(2));
	$("#iibbPercentageOfSellPrice").val((100 * iibb / pvai).toFixed(2));

	$("#ggoPercentageOfDirectCosts").val((100 * ggo / directCosts).toFixed(2));
	$("#ggoPercentageOfSellPrice").val((100 * ggo / pvai).toFixed(2));

	$("#indirectOverheadCalculatedAmountPercentageOfDirectCosts").val((100 * indirectOverhead / directCosts).toFixed(2));
	$("#indirectOverheadCalculatedAmountPercentageOfSellPrice").val((100 * indirectOverhead / pvai).toFixed(2));

	$("#ggPercentageOfDirectCosts").val((100 * gg / directCosts).toFixed(2));
	$("#ggPercentageOfSellPrice").val((100 * gg / pvai).toFixed(2));

	$("#profitPercentageOfDirectCosts").val((100 * profit / directCosts).toFixed(2));
	$("#profitPercentageOfSellPrice").val((100 * profit / pvai).toFixed(2));

	$("#ggbPercentageOfDirectCosts").val((100 * ggb / directCosts).toFixed(2));
	$("#ggbPercentageOfSellPrice").val((100 * ggb / pvai).toFixed(2));

	$("#pvaiPercentageOfDirectCosts").val((100 * pvai / directCosts).toFixed(2));
	$("#pvaiPercentageOfSellPrice").val((100 * pvai / pvai).toFixed(2));

	for (i = 0; i < itemsQuantity; i++) { 
		var amount = $("#amount-"+i).val();
		$("#percentageOfDirectCosts-"+i).val((100*amount / directCosts).toFixed(2));
		$("#percentageOfSellPrice-"+i).val((100*amount / pvai).toFixed(2));
	}
}

$(function() {
	calculateBudget();
	$("input:not([type='submit'])").prop( "disabled", true );
	$("select").prop( "disabled", true );
});

</script>
</body>

</html>