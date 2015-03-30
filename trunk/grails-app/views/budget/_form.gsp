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

<div class="col-md-12 ${hasErrors(bean: budgetInstance, field: 'directCosts', 'has-error')} required">
	<label for="directCosts" class="control-label"><g:message code="budget.directCosts.label" default="Direct Costs" /><span class="required-indicator">*</span></label>
	<div>
		<g:field type="text" class="form-control" name="directCosts" value="${fieldValue(bean: budgetInstance, field: 'directCosts')}" required=""/>
	</div>
</div>

<div class="col-md-12" >	
<h4><g:message code="budget.items.label" /></h4>
<div id="items" class="table-responsive">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th>${message(code: 'budgetItem.concept.label')}</th>
				<th>${message(code: 'budgetItem.amount.label')}</th>
				<th>${message(code: 'default.button.delete.label')}</th>
			</tr>
		</thead>
		<tbody id="items-table">
			<g:each var="budgetItemInstance" in="${budgetInstance.items}" status="i">
				<tr class="form-inline" id="items-${i}">
					<td class="td-intableform"><g:select class="input-intableform form-control" id="concept-${i}" name="items[${i}].concept.id" from="${mgmt.concept.Concept.findAllByCodeLike('L%')}" optionKey="id" required="" value="${budgetItemInstance.concept.id}"/></td>
					<td class="td-intableform"><g:field type="text" class="input-intableform form-control right-aligned" name="items[${i}].amount" id="amount-${i}" value="${budgetItemInstance.amount}" required=""/></td>
					<td><button type="button" onclick="$('#items-${i}').remove();refreshTotals();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				</tr>
			</g:each>
		</tbody>
	</table>
</div>
<button type="button" class="btn btn-default" onclick="addItem();" >Agregar item</button>

<table>
	<tbody>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'iibbPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.iibbPercentage.label" default="Iibb Percentage" /></td>
			<td><g:field type="text" class="form-control" name="iibbPercentage" value="${fieldValue(bean: budgetInstance, field: 'iibbPercentage')}" required=""/></td>
		</tr>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'indirectOverheadPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.indirectOverheadPercentage.label" /></td>
			<td><g:field type="text" class="form-control" name="indirectOverheadPercentage" value="${fieldValue(bean: budgetInstance, field: 'indirectOverheadPercentage')}" required=""/></td>
		</tr>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'profitPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.profitPercentage.label" /></td>
			<td><g:field type="text" class="form-control" name="profitPercentage" value="${fieldValue(bean: budgetInstance, field: 'profitPercentage')}" required=""/></td>
		</tr>
		<tr class="form-inline ${hasErrors(bean: budgetInstance, field: 'ivaPercentage', 'has-error')}">
			<td class="td-intableform"><g:message code="budget.ivaPercentage.label" /></td>
			<td><g:field type="text" class="form-control" name="ivaPercentage" value="${fieldValue(bean: budgetInstance, field: 'ivaPercentage')}" required=""/></td>
		</tr>


	</tbody>

</table>
</div>


<div class="hide" >
<table>
	<tr class="form-inline" id="item-model">
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" id="concept-xyz" name="items[xyz].concept.id" from="${mgmt.concept.Concept.findAllByCodeLike('L%')}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:field disabled="disabled" type="text" class="input-intableform form-control right-aligned" name="items[xyz].amount" id="amount-xyz" value="" required=""/></td>
		<td><button type="button" class="deleteButton"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
	</tr>
</table>

</div>


<script>

var itemsQuantity = ${budgetInstance.items?.size()?:0};
	
function addItem(){
	$tmc = $("#item-model").clone();
	$tmc.attr('id', 'items-'+ itemsQuantity);
	$("input, select, textarea", $tmc).each(function(){
		$(this).attr('name',$(this).attr('name').replace('xyz',itemsQuantity));
		$(this).attr('id',$(this).attr('id').replace('xyz',itemsQuantity));		
		$(this).prop("disabled", false);
	});
	var currentItemQuantity = itemsQuantity;
	$(".deleteButton", $tmc).click(function() {
		$('#items-'+currentItemQuantity).remove();
	});
	
	$tmc.appendTo("#items-table");
	itemsQuantity = itemsQuantity + 1;
}
</script>