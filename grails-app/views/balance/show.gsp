<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>
<%@ page import="mgmt.work.Budget" %>

<div class="col-md-4">
	<label for="name" class="control-label"><g:message code="work.label" /> </label>
	<div>
		<g:field type="number" required="" class="form-control" name="code" value="${work.code}"/>
		<g:textField required="" class="form-control" name="name" value="${work.name}"/>
		<g:textField required="" class="form-control" name="name" value="${new Date().format("dd/MM/yyyy")}"/>
	</div>
</div>



<div class="col-md-12" >
<hr/>
</div>
<div class="col-md-9" >

<table class="table table-condensed table-bordered" >
	<tbody>
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.income.label" /></td>
			<td class="td-intableform center-aligned"><g:message code="balance.amountWithoutIva.label" /></td>
			<td colspan="3" class="td-intableform"></td>
			<td class="td-intableform center-aligned"><g:message code="balance.iva.label" /></td>
		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.clientPayment.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.income.amount}"/></td>
			<td colspan="3" class="td-intableform"></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.income.iva}"/></td>
		</tr>
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.otherIncome.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.otherIncome.amount}"/></td>
			<td colspan="4" class="td-intableform"></td>
		</tr>
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.totalIncome.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount}"/></td>
			<td colspan="3" class="td-intableform"></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.income.iva}"/></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.expenses.label" /></td>
			<td class="td-intableform"></td>
			<td class="td-intableform center-aligned"><g:message code="balance.percentageOfDirectCosts.label" /></td>
			<td class="td-intableform center-aligned"><g:message code="balance.percentageOfSellPrice.label" /></td>
			<td class="td-intableform"></td>
			<td class="td-intableform center-aligned"><g:message code="balance.iva.label" /></td>
		</tr>
		
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.totalDirectCost.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.directCosts.amount / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount? 100 * amounts.directCosts.amount / amounts.sellPrice.amount:0}"/></td>
			<td class="td-intableform"></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.iva}"/></td>
		</tr>
		
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.generalExpenses.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.generalExpenses.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.generalExpenses.amount / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * amounts.generalExpenses.amount / amounts.sellPrice.amount:0}"/></td>
			<td class="td-intableform"></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.generalExpenses.iva}"/></td>
		</tr>
		
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.indirectGeneralExpenses.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.indirectGeneralExpenses}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.indirectGeneralExpenses / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * amounts.indirectGeneralExpenses / amounts.sellPrice.amount:0}"/></td>
			<td colspan="2" class="td-intableform right-aligned"></td>
		</tr>
		
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.totalGeneralExpenses.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.totalGeneralExpenses.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.totalGeneralExpenses.amount / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * amounts.totalGeneralExpenses.amount / amounts.sellPrice.amount:0}"/></td>
			<td class="td-intableform"></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.totalGeneralExpenses.iva}"/></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.totalExpenses.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.totalExpenses.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.totalExpenses.amount / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * amounts.totalExpenses.amount / amounts.sellPrice.amount:0}"/></td>
			<td class="td-intableform"></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.totalExpenses.iva}"/></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.benefits.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.calculatedBenefits.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.calculatedBenefits.amount / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * amounts.calculatedBenefits.amount / amounts.sellPrice.amount:0}"/></td>
			<td class="td-intableform center-aligned">Saldo IVA</td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.calculatedBenefits.iva}"/></td>
		</tr>
		
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.generalExpensesPlusBenefits.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.calculatedBenefits.amount + amounts.indirectGeneralExpenses }"/></td>
			<td colspan="4" class="td-intableform"></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.sellPrice.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.sellPrice.amount / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * amounts.sellPrice.amount / amounts.sellPrice.amount:0}"/></td>
			<td colspan="2" class="td-intableform"></td>
		</tr>
		
		<tr class="form-inline">
			<td class="td-intableform"><g:message code="balance.ivaPercentage.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount? 100* amounts.sellPrice.iva / amounts.sellPrice.amount :0}"/></td>
			<td colspan="4" class="td-intableform"></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.finalSellPrice.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.iva + amounts.sellPrice.amount }"/></td>
			<td colspan="4" class="td-intableform"></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.coefficient.label" /></td>
			<td class="td-intableform"></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.000" number="${amounts.directCosts.amount?amounts.sellPrice.amount / amounts.directCosts.amount:0 }"/></td>
			<td colspan="3" class="td-intableform"></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.retiredBenefits.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.retiredBenefits.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * amounts.calculatedBenefits.amount / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * amounts.retiredBenefits.amount / amounts.sellPrice.amount:0}"/></td>
			<td colspan="2" class="td-intableform"></td>
		</tr>
		
		<tr class="form-inline important-bold">
			<td class="td-intableform"><g:message code="balance.availableBalance.label" /></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.calculatedBenefits.amount - amounts.retiredBenefits.amount}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.directCosts.amount?100 * (amounts.calculatedBenefits.amount - amounts.retiredBenefits.amount) / amounts.directCosts.amount:0}"/></td>
			<td class="td-intableform right-aligned"><g:formatNumber format="###,##0.00" number="${amounts.sellPrice.amount?100 * (amounts.calculatedBenefits.amount - amounts.retiredBenefits.amount) / amounts.sellPrice.amount:0}"/></td>
			<td colspan="2" class="td-intableform"></td>
		</tr>
		
	</tbody>
</table>
</div>


<script>


$(function() {
	$("input:not([type='submit'])").prop( "disabled", true );
	$("select").prop( "disabled", true );
});

</script>
</body>

</html>