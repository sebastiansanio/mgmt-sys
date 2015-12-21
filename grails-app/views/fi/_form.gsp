<%@ page import="mgmt.movement.Movement" %>

<div class="container-fluid">

<g:hiddenField name="type" value="fi" />

<div class="col-md-3 ${hasErrors(bean: movementInstance, field: 'note', 'has-error')} ">
	<label for="type" class="control-label"><g:message code="movement.note.label" default="Note" /></label>
	<div>
		<g:textArea class="form-control mayus" name="note" value="${movementInstance.note}"/>
	</div>
</div>

</div>

<div id="items" class="table-responsive">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th>${message(code: 'movementItem.workFrom.label')}</th>
				<th>${message(code: 'movementItem.workTo.label')}</th>
				<th>${message(code: 'movementItem.concept.label')}</th>
				<th>${message(code: 'movementItem.description.label')}</th>
				<th>${message(code: 'movementItem.unit.label')}</th>
				<th>${message(code: 'movementItem.quantity.label')}</th>
				<th>${message(code: 'movementItem.unitPrice.label')}</th>
				<th>${message(code: 'movementItem.amount.label')}</th>
				<th>${message(code: 'default.button.delete.label')}</th>
			</tr>
		</thead>
		<tbody id="items-table">
			<g:if test="${movementInstance.items}">
			<g:each var="itemPosition" in="${(0..((movementInstance.items.size()/2)-1))}" status="i">
				<tr class="form-inline" id="items-${itemPosition*2}">
					<td class="td-intableform"><g:select class="position-0 input-intableform form-control" id="items[${itemPosition*2}].work" name="items[${itemPosition*2}].work.id" from="${mgmt.work.Work.findAllByFinishedOrId(false,movementInstance.items[itemPosition*2]?.work?.id)}" optionKey="id" required="" value="${movementInstance.items[itemPosition*2]?.work?.id}"/></td>
					<td class="td-intableform"><g:select class="position-1 input-intableform form-control" id="items[${itemPosition*2+1}].work" name="items[${itemPosition*2+1}].work.id" from="${mgmt.work.Work.findAllByFinishedOrId(false,movementInstance.items[itemPosition*2+1]?.work?.id)}" optionKey="id" required="" value="${movementInstance.items[itemPosition*2+1]?.work?.id}"/></td>
					<td class="td-intableform"><g:select class="position-0 input-intableform form-control" id="items[${itemPosition*2}].concept" name="items[${itemPosition*2}].concept.id" from="${mgmt.concept.Concept.findAllByValidInFiWork(true)}" optionKey="id" required="" value="${movementInstance.items[itemPosition*2]?.concept?.id}"/></td>
					<td class="td-intableform"><g:textArea cols="60" class="position-0 mayus input-intableform form-control" name="items[${itemPosition*2}].description" value="${movementInstance.items[itemPosition*2]?.description}"/></td>
					<td class="td-intableform"><g:select class="position-0 input-intableform form-control" id="items[${itemPosition*2}].unit.id" name="items[${itemPosition*2}].unit.id" from="${mgmt.products.UnitOfMeasurement.list()}" optionKey="id" required="" value="${movementInstance.items[itemPosition*2]?.unit?.id}"/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${itemPosition*2}');" type="text" class="position-0 input-intableform form-control numberinput right-aligned" id="quantity-${itemPosition*2}" name="items[${itemPosition*2}].quantity" value="${movementInstance.items[itemPosition*2]?.quantity}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${itemPosition*2}');" type="text" class="position-0 input-intableform form-control numberinput right-aligned" id="unitPrice-${itemPosition*2}" name="items[${itemPosition*2}].unitPrice" value="${movementInstance.items[itemPosition*2]?.unitPrice}" required=""/></td>
					<td class="td-intableform"><g:field type="text" class="position-0 input-intableform form-control field-amount right-aligned" id="amount-${itemPosition*2}" name="items[${itemPosition*2}].amount" value="${movementInstance.items[itemPosition*2]?.amount}" required=""/></td>
					<td><button type="button" onclick="$('#items-${itemPosition*2}').remove();refreshTotals();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				</tr>
			</g:each>
			</g:if>
		</tbody>
		<tbody>
			<tr class="important-bold">
				<td colspan="7">${message(code:'default.totals.label')}</td>
				<td class="right-aligned" id="total-amount"></td>
			</tr>
		</tbody>
	</table>
	
</div>
<button type="button" class="btn btn-default" onclick="addItem();" >Agregar item</button>


<div class="hide" >

<table>
	<tr class="form-inline" id="item-model">
		<td class="td-intableform"><g:select disabled="disabled" class="position-0 input-intableform form-control" name="items[xyz].work.id" from="${mgmt.work.Work.findAllByFinished(false)}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="position-1 input-intableform form-control" name="items[xyz].work.id" from="${mgmt.work.Work.findAllByFinished(false)}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="position-0 input-intableform form-control" name="items[xyz].concept.id" from="${mgmt.concept.Concept.findAllByValidInFiWork(true)}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:textArea cols="60" disabled="disabled" class="position-0 mayus input-intableform form-control" name="items[xyz].description" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="position-0 input-intableform form-control" name="items[xyz].unit.id" from="${mgmt.products.UnitOfMeasurement.list()}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="position-0 input-intableform form-control numberinput right-aligned" id="quantity-xyz" name="items[xyz].quantity" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="position-0 input-intableform form-control numberinput right-aligned" id="unitPrice-xyz" name="items[xyz].unitPrice" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="position-0 input-intableform form-control field-amount right-aligned" id="amount-xyz" name="items[xyz].amount" value="" required=""/></td>
		<td><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
	</tr>
</table>


</div>

<script>

var itemsQuantity = ${movementInstance?.items?.size()?:0};
	
function addItem(){
	$tmc = $("#item-model").clone();
	$tmc.attr('id', 'items-'+ itemsQuantity);
	$(".position-0", $tmc).each(function(){
		$(this).attr('name',$(this).attr('name').replace('xyz',itemsQuantity));
		$(this).attr('id',$(this).attr('id').replace('xyz',itemsQuantity));		
		$(this).prop("disabled", false);
	});
	$(".position-1", $tmc).each(function(){
		$(this).attr('name',$(this).attr('name').replace('xyz',itemsQuantity+1));
		$(this).attr('id',$(this).attr('id').replace('xyz',itemsQuantity+1));		
		$(this).prop("disabled", false);
	});
	var currentItemQuantity = itemsQuantity;
	$(".numberinput", $tmc).change(function() {
		refreshTotal(currentItemQuantity);
	});
	$(".deleteButton", $tmc).click(function() {
		$('#items-'+currentItemQuantity).remove();
		refreshTotals();
	});
	
	$tmc.appendTo("#items-table");
	itemsQuantity = itemsQuantity + 2;
	$('#supplier-'+currentItemQuantity).chosen({width: "200px"});
}

function refreshTotal(idx){
	var total = safeParseFloat($('#quantity-'+idx).val()) * safeParseFloat($('#unitPrice-'+idx).val());
	$('#amount-'+idx).val(total);
	refreshTotals();
}

function refreshTotals(){
	var amount = 0;
	$(".field-amount" ).each(function( index ) {
		amount = amount + safeParseFloat($(this ).val());
	});
	$('#total-amount').text(amount.toFixed(2));
}

function safeParseFloat(inputString){
	var result = parseFloat(inputString);
	if(isNaN(result)){
		result = 0;
	}
	return result;
}

$(function() {
	refreshTotals();

	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});

	});

	if(itemsQuantity == 0){
		addItem();
	}
});

</script>
