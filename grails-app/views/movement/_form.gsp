<%@ page import="mgmt.movement.Movement" %>

<div class="container-fluid">

<div class="col-md-3 ${hasErrors(bean: movementInstance, field: 'type', 'has-error')} ">
	<label for="type" class="control-label"><g:message code="movement.type.label" default="Type" /></label>
	<div>
		<g:select class="form-control" name="type" from="${movementInstance.constraints.type.inList}" value="${movementInstance?.type}" valueMessagePrefix="movement.type" noSelection="['': '']"/>
	</div>
</div>

</div>

<hr/>
<h4><g:message code="movement.items.label" /></h4>
<div id="items" class="table-responsive">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th>${message(code: 'movementItem.work.label')}</th>
				<th>${message(code: 'movementItem.supplier.label')}</th>
				<th>${message(code: 'movementItem.concept.label')}</th>
				<th>${message(code: 'movementItem.description.label')}</th>
				<th>${message(code: 'movementItem.invoiceType.label')}</th>
				<th>${message(code: 'movementItem.invoiceNumber.label')}</th>
				<th>${message(code: 'movementItem.date.label')}</th>
				<th>${message(code: 'movementItem.amount.label')}</th>
				<th>${message(code: 'movementItem.iva.label')}</th>
				<th>${message(code: 'movementItem.iibb.label')}</th>
				<th>${message(code: 'movementItem.otherPerceptions.label')}</th>
				<th>${message(code: 'movementItem.total.label')}</th>
				<th>${message(code: 'default.button.delete.label')}</th>
			</tr>
		</thead>
		<tbody id="items-table">
			<g:each var="movementItemInstance" in="${movementInstance?.items}" status="i">
				<tr class="form-inline" id="items-${i}">
					<td class="td-intableform"><g:select noSelection="${['null':'00 - Gastos generales']}" class="input-intableform form-control" id="items[${i}].work" name="items[${i}].work.id" from="${mgmt.work.Work.list()}" optionKey="id" required="" value="${movementItemInstance?.work?.id}"/></td>
					<td class="td-intableform"><g:select class="select-chosen supplier-select form-control" id="supplier-${i}" name="items[${i}].supplier.id" from="${[movementItemInstance?.supplier]}" optionKey="id" required="" value="${movementItemInstance?.supplier?.id}"/></td>
					<td class="td-intableform"><g:select class="input-intableform form-control" id="items[${i}].concept" name="items[${i}].concept.id" from="${mgmt.concept.Concept.list()}" optionKey="id" required="" value="${movementItemInstance?.concept?.id}"/></td>
					<td class="td-intableform"><g:textArea cols="60" class="input-intableform form-control" name="items[${i}].description" value="${movementItemInstance?.description}"/></td>
					<td class="td-intableform"><g:select class="input-intableform form-control" id="items[${i}].invoiceType" name="items[${i}].invoiceType.id" from="${mgmt.invoice.InvoiceType.list()}" optionKey="id" required="" value="${movementItemInstance?.invoiceType?.id}"/></td>
					<td class="td-intableform"><g:textField class="input-intableform form-control" name="items[${i}].invoiceNumber" value="${movementItemInstance?.invoiceNumber}"/></td>
					<td class="td-intableform"><bs:datePicker class="input-intableform form-control" name="items[${i}].date" precision="day"  value="${movementItemInstance?.date}"  /> </td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput" id="amount-${i}" name="items[${i}].amount" value="${movementItemInstance.amount}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput" id="iva-${i}" name="items[${i}].iva" value="${movementItemInstance.iva}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput" id="iibb-${i}" name="items[${i}].iibb" value="${movementItemInstance.iibb}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput" id="otherPerceptions-${i}" name="items[${i}].otherPerceptions" value="${movementItemInstance.otherPerceptions}" required=""/></td>
					<td class="td-intableform"><g:field type="text" class="input-intableform form-control" name="items[${i}].total" id="total-${i}" value="${movementItemInstance.total}" required=""/></td>
					<td><button type="button" onclick="$('#items-${i}').remove();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				</tr>
			</g:each>
		</tbody>
	</table>
	
</div>
<button type="button" class="btn btn-default" onclick="addItem();" >Agregar item</button>

<hr/>

<h4><g:message code="movement.payments.label" /></h4>
<div id="items">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th>${message(code: 'payment.account.label')}</th>
				<th>${message(code: 'payment.amount.label')}</th>
				<th>${message(code: 'payment.paymentDate.label')}</th>
				<th>${message(code: 'payment.checkNumber.label')}</th>
				<th>${message(code: 'payment.note.label')}</th>
				<th>${message(code: 'default.button.delete.label')}</th>
			</tr>
		</thead>
		<tbody id="payments-table" >
			<g:each var="paymentInstance" in="${movementInstance?.payments}" status="i">
				<tr class="form-inline" id="payments-${i}">
					<td class="td-intableform"><g:select class="input-intableform form-control" id="payments[${i}].account" name="payments[${i}].account" from="${mgmt.account.Account.list()}" optionKey="id" required="" value="${paymentInstance?.account?.id}"/></td>
					<td class="td-intableform"><g:field type="text" class="input-intableform form-control" name="payments[${i}].amount" value="${paymentInstance.amount}" required=""/></td>
					<td class="td-intableform"><bs:datePicker class="input-intableform form-control" name="payments[${i}].paymentDate" precision="day"  value="${paymentInstance?.paymentDate}"  /> </td>
					<td class="td-intableform"><g:textField class="input-intableform form-control" name="payments[${i}].checkNumber" value="${paymentInstance?.checkNumber}"/></td>
					<td class="td-intableform"><g:textField class="input-intableform form-control" name="payments[${i}].note" value="${paymentInstance?.note}"/></td>
					<td><button type="button" onclick="$('#payments-${i}').remove();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				</tr>
			</g:each>
		</tbody>
	</table>
	
</div>
<button type="button" class="btn btn-default" onclick="addPayment();" >Agregar pago</button>



<div class="hide" >

<table>
	<tr class="form-inline" id="item-model">
		<td class="td-intableform"><g:select noSelection="${['null':'00 - Gastos generales']}" disabled="disabled" class="input-intableform form-control" name="items[xyz].work.id" from="${mgmt.work.Work.list()}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="supplier-select-model form-control" id="supplier-xyz" name="items[xyz].supplier.id" from="${mgmt.persons.Supplier.list()}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" name="items[xyz].concept.id" from="${mgmt.concept.Concept.list()}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:textArea cols="60" disabled="disabled" class="input-intableform form-control" name="items[xyz].description" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" name="items[xyz].invoiceType.id" from="${mgmt.invoice.InvoiceType.list()}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:textField disabled="disabled" class="input-intableform form-control" name="items[xyz].invoiceNumber" value=""/></td>
		<td class="td-intableform"><bs:datePicker disabled="true" class="input-intableform form-control" name="items[xyz].date" precision="day"  value=""  /> </td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput" id="amount-xyz" name="items[xyz].amount" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput" id="iva-xyz" name="items[xyz].iva" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput" id="iibb-xyz" name="items[xyz].iibb" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput" id="otherPerceptions-xyz" name="items[xyz].otherPerceptions" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control" id="total-xyz" name="items[xyz].total" value="" required=""/></td>
		<td><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
	</tr>
</table>

<table>
	<tr class="form-inline" id="payment-model">
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" name="payments[xyz].account.id" from="${mgmt.account.Account.list()}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control" name="payments[xyz].amount" value="" required=""/></td>
		<td class="td-intableform"><bs:datePicker disabled="true" class="input-intableform form-control" name="payments[xyz].paymentDate" precision="day"  value=""  /> </td>
		<td class="td-intableform"><g:textField disabled="disabled" class="input-intableform form-control" name="payments[xyz].checkNumber" value=""/></td>
		<td class="td-intableform"><g:textField disabled="disabled" class="input-intableform form-control" name="payments[xyz].note" value=""/></td>
		<td><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
	</tr>
</table>


</div>

<script>

var itemsQuantity = ${movementInstance?.items?.size()?:0};
	
function addItem(){
	$tmc = $("#item-model").clone();
	$tmc.attr('id', 'items-'+ itemsQuantity);
	$("input, select, textarea", $tmc).each(function(){
		$(this).attr('name',$(this).attr('name').replace('xyz',itemsQuantity));
		$(this).attr('id',$(this).attr('id').replace('xyz',itemsQuantity));		
		$(this).prop("disabled", false);
	});
	var currentItemQuantity = itemsQuantity;
	$(".numberinput", $tmc).change(function() {
		refreshTotal(currentItemQuantity);
	});
	$(".deleteButton", $tmc).click(function() {
		$('#items-'+currentItemQuantity).remove();
	});
	
	$tmc.appendTo("#items-table");
	itemsQuantity = itemsQuantity + 1;
	$('#supplier-'+currentItemQuantity).chosen({width: "200px"});
}

var paymentsQuantity = ${movementInstance?.payments?.size()?:0};

function addPayment(){
	$tmc = $("#payment-model").clone();
	$tmc.attr('id', 'payments-'+ paymentsQuantity);
	$("input, select, textarea", $tmc).each(function(){
		$(this).attr('name',$(this).attr('name').replace('xyz',paymentsQuantity));
		$(this).attr('id',$(this).attr('id').replace('xyz',paymentsQuantity));		
		$(this).prop("disabled", false);
	});
	var currentPaymentsQuantity = paymentsQuantity;
	$(".deleteButton", $tmc).click(function() {
		$('#payments-'+currentPaymentsQuantity).remove();
	});
	
	$tmc.appendTo("#payments-table");
	paymentsQuantity = paymentsQuantity + 1;
	
}

function refreshTotal(idx){
	var total = safeParseFloat($('#amount-'+idx).val())+ safeParseFloat($('#iva-'+idx).val()) + safeParseFloat($('#iibb-'+idx).val()) + safeParseFloat($('#otherPerceptions-'+idx).val());
	$('#total-'+idx).val(total);
}

function safeParseFloat(inputString){
	var result = parseFloat(inputString);
	if(isNaN(result)){
		result = 0;
	}
	return result;
}

$(function() {
	$('.supplier-select').append($(".supplier-select-model > option").clone());
	$(".select-chosen").chosen({width: "200px"});
});

</script>
