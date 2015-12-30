<%@ page import="mgmt.movement.Movement" %>

<div class="container-fluid">

<g:hiddenField name="type" value="os" />

<div class="col-md-3 ${hasErrors(bean: movementInstance, field: 'note', 'has-error')} ">
	<label for="type" class="control-label"><g:message code="movement.note.label" default="Note" /></label>
	<div>
		<g:textArea class="form-control mayus" name="note" value="${movementInstance.note}"/>
	</div>
</div>

<g:if test="${movementInstance.number}">
<div class="col-md-2" >
	<label for="toString" class="control-label"><g:message code="movement.label" /></label>
	<div>
		<g:field type="text" disabled="true" class="form-control mayus importantBig" name="toString" value="${movementInstance.toString()}"/>
	</div>
</div>

<div class="col-md-1" >
	<label for="dateCreated" class="control-label"><g:message code="movement.dateCreated.label" /></label>
	<div>
		<g:field type="text" disabled="true" class="form-control mayus importantBig" name="dateCreated" value="${movementInstance.dateCreated?.format("dd/MM/yyyy")}"/>
	</div>
</div>
</g:if>

</div>

<h4><g:message code="movement.items.label" /></h4>
<div id="items" class="table-responsive">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.work.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.supplier.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.concept.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.description.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.invoiceType.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.invoiceNumber.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.date.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.amount.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.iva.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.iibb.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.otherPerceptions.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.total.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'default.button.delete.label')}</th>
			</tr>
		</thead>
		<tbody id="items-table">
			<g:each var="movementItemInstance" in="${movementInstance?.items}" status="i">
				<tr class="form-inline" id="items-${i}">
					<td class="td-intableform"><g:select onchange="refreshConcepts('${i}');" noSelection="${['null':'00 - Gastos generales']}" class="input-intableform form-control" id="work-${i}" name="items[${i}].work.id" from="${mgmt.work.Work.findAllByFinishedOrId(false,movementItemInstance?.work?.id,[sort:'code'])}" optionKey="id" required="" value="${movementItemInstance?.work?.id}"/></td>
					<td class="td-intableform"><g:select class="select-chosen supplier-select form-control" id="supplier-${i}" name="items[${i}].supplier.id" from="${[movementItemInstance?.supplier]}" optionKey="id" required="" value="${movementItemInstance?.supplier?.id}"/></td>
					<td class="td-intableform"><g:select class="input-intableform form-control ${movementItemInstance.work?'conceptsWork':'conceptsNoWork'}" id="concept-${i}" name="items[${i}].concept.id" from="${[movementItemInstance?.concept]}" optionKey="id" required="" value="${movementItemInstance?.concept?.id}"/></td>
					<td class="td-intableform"><g:textArea cols="60" class="mayus input-intableform form-control vertical-center-aligned" name="items[${i}].description" value="${movementItemInstance?.description}"/></td>
					<td class="td-intableform"><g:select class="input-intableform form-control" id="items[${i}].invoiceType" name="items[${i}].invoiceType.id" from="${mgmt.invoice.InvoiceType.list()}" optionKey="id" required="" value="${movementItemInstance?.invoiceType?.id}"/></td>
					<td class="td-intableform"><g:textField class="input-intableform form-control" name="items[${i}].invoiceNumber" value="${movementItemInstance?.invoiceNumber}"/></td>
					<td class="td-intableform"><bs:datePicker class="input-intableform form-control center-aligned" name="items[${i}].date" precision="day"  value="${movementItemInstance?.date}"  /> </td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput field-amount right-aligned" id="amount-${i}" name="items[${i}].amount" value="${movementItemInstance.amount}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput field-iva right-aligned" id="iva-${i}" name="items[${i}].iva" value="${movementItemInstance.iva}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput field-iibb right-aligned" id="iibb-${i}" name="items[${i}].iibb" value="${movementItemInstance.iibb}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control numberinput field-otherPerceptions right-aligned" id="otherPerceptions-${i}" name="items[${i}].otherPerceptions" value="${movementItemInstance.otherPerceptions}" required=""/></td>
					<td class="td-intableform"><g:field type="text" class="input-intableform form-control field-total right-aligned" name="items[${i}].total" id="total-${i}" value="${movementItemInstance.total}" required=""/></td>
					<td class="center-aligned"><button type="button" onclick="$('#items-${i}').remove();refreshTotals();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				</tr>
			</g:each>
		</tbody>
		<tbody>
			<tr class="important-bold">
				<td colspan="7">${message(code:'default.totals.label')}</td>
				<td class="right-aligned" id="total-amount"></td>
				<td class="right-aligned" id="total-iva"></td>
				<td class="right-aligned" id="total-iibb"></td>
				<td class="right-aligned" id="total-otherPerceptions"></td>
				<td class="right-aligned" id="total-total"></td>
			</tr>
		</tbody>
	</table>
	
</div>
<button type="button" class="btn btn-default" onclick="addItem();" >Agregar item</button>

<h4><g:message code="movement.payments.label" /></h4>
<div id="items">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.account.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.amount.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.paymentDate.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.checkNumber.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.note.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'default.button.delete.label')}</th>
			</tr>
		</thead>
		<tbody id="payments-table" >
			<g:each var="paymentInstance" in="${movementInstance?.payments}" status="i">
				<tr class="form-inline" id="payments-${i}">
					<td class="td-intableform"><g:select class="input-intableform form-control" id="payments[${i}].account" name="payments[${i}].account" from="${mgmt.account.Account.list(sort:'code')}" optionKey="id" required="" value="${paymentInstance?.account?.id}"/></td>
					<td class="td-intableform"><g:field type="text" onchange="refreshPaymentTotal();" class="input-intableform form-control field-payment-amount right-aligned" name="payments[${i}].amount" value="${paymentInstance.amount}" required=""/></td>
					<td class="td-intableform"><bs:datePicker class="input-intableform form-control center-aligned" name="payments[${i}].paymentDate" precision="day"  value="${paymentInstance?.paymentDate}"  /> </td>
					<td class="td-intableform"><g:textField class="input-intableform form-control" name="payments[${i}].checkNumber" value="${paymentInstance?.checkNumber}"/></td>
					<td class="td-intableform"><g:textField class="mayus input-intableform form-control" name="payments[${i}].note" value="${paymentInstance?.note}"/></td>
					<td class="center-aligned"><button type="button" onclick="$('#payments-${i}').remove();refreshPaymentTotal();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				</tr>
			</g:each>
		</tbody>
		<tbody>
			<tr class="important-bold">
				<td>${message(code:'default.totals.label')}</td>
				<td class="right-aligned" id="total-payment-amount"></td>
				<td colspan="3"></td>
			</tr>
		</tbody>
	</table>
	
</div>
<button type="button" class="btn btn-default" onclick="addPayment();" >Agregar pago</button>

<div class="hide" >

<table>
	<tr class="form-inline" id="item-model">
		<td class="td-intableform"><g:select noSelection="${['null':'00 - Gastos generales']}" disabled="disabled" class="work-model input-intableform form-control" id="work-xyz" name="items[xyz].work.id" from="${mgmt.work.Work.findAllByFinished(false,[sort:'code'])}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="supplier-select-model form-control" id="supplier-xyz" name="items[xyz].supplier.id" from="${mgmt.persons.Supplier.list(sort:'name')}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" id="concept-xyz" name="items[xyz].concept.id" from="${mgmt.concept.Concept.findAllByValidInOsNoWork(true,[sort:'code'])}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:textArea cols="60" disabled="disabled" class="mayus input-intableform form-control vertical-center-aligned" name="items[xyz].description" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" name="items[xyz].invoiceType.id" from="${mgmt.invoice.InvoiceType.list()}" optionKey="id" required="" value="${mgmt.invoice.InvoiceType.findByCode('SD')?.id}"/></td>
		<td class="td-intableform"><g:textField disabled="disabled" class="input-intableform form-control" name="items[xyz].invoiceNumber" value=""/></td>
		<td class="td-intableform"><bs:datePicker disabled="true" class="input-intableform form-control center-aligned" name="items[xyz].date" precision="day"  value=""  /> </td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput field-amount right-aligned" id="amount-xyz" name="items[xyz].amount" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput field-iva right-aligned" id="iva-xyz" name="items[xyz].iva" value="0" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput field-iibb right-aligned" id="iibb-xyz" name="items[xyz].iibb" value="0" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput field-otherPerceptions right-aligned" id="otherPerceptions-xyz" name="items[xyz].otherPerceptions" value="0" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control field-total right-aligned" id="total-xyz" name="items[xyz].total" value="0" required=""/></td>
		<td class="center-aligned"><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
	</tr>
</table>

<table>
	<tr class="form-inline" id="payment-model">
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" name="payments[xyz].account.id" from="${mgmt.account.Account.list(sort:'code')}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:field type="text" onchange="refreshPaymentTotal();" disabled="disabled" class="input-intableform form-control field-payment-amount right-aligned" name="payments[xyz].amount" value="" required=""/></td>
		<td class="td-intableform"><bs:datePicker disabled="true" class="input-intableform form-control center-aligned" name="payments[xyz].paymentDate" precision="day"  value=""  /> </td>
		<td class="td-intableform"><g:textField disabled="disabled" class="input-intableform form-control" name="payments[xyz].checkNumber" value=""/></td>
		<td class="td-intableform"><g:textField disabled="disabled" class="mayus input-intableform form-control" name="payments[xyz].note" value=""/></td>
		<td class="center-aligned"><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
	</tr>
</table>

<g:select disabled="disabled" class="input-intableform form-control" id="conceptsWork" name="conceptsWork" from="${mgmt.concept.Concept.findAllByValidInOsWork(true,[sort:'code',order:'asc'])}" optionKey="id" required="" value=""/>
<g:select disabled="disabled" class="input-intableform form-control" id="conceptsNoWork" name="conceptsNoWork" from="${mgmt.concept.Concept.findAllByValidInOsNoWork(true,[sort:'code',order:'asc'])}" optionKey="id" required="" value=""/>


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
	$(".work-model", $tmc).change(function() {
		refreshConcepts(currentItemQuantity);
	});
	$(".deleteButton", $tmc).click(function() {
		$('#items-'+currentItemQuantity).remove();
		refreshTotals();
	});
	
	$tmc.appendTo("#items-table");
	itemsQuantity = itemsQuantity + 1;
	$('#supplier-'+currentItemQuantity).chosen({search_contains: true, width: "200px"});
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
		refreshPaymentTotal();
	});
	
	$tmc.appendTo("#payments-table");

	if(paymentsQuantity == 0){
		$(".field-payment-amount",$tmc).val($("#total-total").text());
		refreshPaymentTotal();
	}
	
	paymentsQuantity = paymentsQuantity + 1;
	
}

function refreshTotal(idx){
	var total = safeParseFloat($('#amount-'+idx).val())+ safeParseFloat($('#iva-'+idx).val()) + safeParseFloat($('#iibb-'+idx).val()) + safeParseFloat($('#otherPerceptions-'+idx).val());
	$('#total-'+idx).val(total.toFixed(2));
	refreshTotals();
}

function refreshTotals(){
	var amount = 0;
	$(".field-amount" ).each(function( index ) {
		amount = amount + safeParseFloat($(this ).val());
	});
	$('#total-amount').text(amount.toFixed(2));
	var iva = 0;
	$(".field-iva" ).each(function( index ) {
		iva = iva + safeParseFloat($(this ).val());
	});
	$('#total-iva').text(iva.toFixed(2));
	var iibb = 0;
	$(".field-iibb" ).each(function( index ) {
		iibb = iibb + safeParseFloat($(this ).val());
	});
	$('#total-iibb').text(iibb.toFixed(2));
	var otherPerceptions = 0;
	$(".field-otherPerceptions" ).each(function( index ) {
		otherPerceptions = otherPerceptions + safeParseFloat($(this ).val());
	});
	$('#total-otherPerceptions').text(otherPerceptions.toFixed(2));
	var total = 0;
	$(".field-total" ).each(function( index ) {
		total = total + safeParseFloat($(this ).val());
	});
	$('#total-total').text(total.toFixed(2));
}
function refreshPaymentTotal(){
	var total = 0;
	$(".field-payment-amount" ).each(function( index ) {
		total = total + safeParseFloat($(this ).val());
	});
	$('#total-payment-amount').text(total.toFixed(2));
}

function safeParseFloat(inputString){
	var result = parseFloat(inputString);
	if(isNaN(result)){
		result = 0;
	}
	return result;
}

function refreshConcepts(idx){
	if($('#work-'+idx).val()=='null'){
		$('#concept-'+idx).empty().append($("#conceptsNoWork > option").clone());
	}else{
		$('#concept-'+idx).empty().append($("#conceptsWork > option").clone());
	}
}

$(function() {
	$('.supplier-select').append($(".supplier-select-model > option").clone());
	$('.conceptsWork').append($("#conceptsWork > option").clone());
	$('.conceptsNoWork').append($("#conceptsNoWork > option").clone());
	$(".select-chosen").chosen({search_contains: true, width: "200px"});
	refreshTotals();
	refreshPaymentTotal();

	$('input[type="submit"]').click(function( event ) {
		if($('#total-total').text() != $('#total-payment-amount').text()){
			alert('${message(code:'movement.amountsNotEqual.error')}');
			event.preventDefault();
		}
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});

	});

	if(itemsQuantity == 0){
		addItem();
	}
});

</script>
