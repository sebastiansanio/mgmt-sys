<%@ page import="mgmt.movement.Movement" %>

<div class="container-fluid">

<g:hiddenField name="type" value="os" />

<div class="col-md-3 ${hasErrors(bean: movementInstance, field: 'note', 'has-error')} ">
	<label for="type" class="control-label"><g:message code="movement.note.label" /></label>
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
				<th class="center-aligned vertical-center-aligned">${message(code: 'movementItem.budget.label')}</th>
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
					<td class="td-intableform"><g:select onchange="refreshConcepts('${i}');refreshBudgets('${i}');" noSelection="${['null':'00 - Gastos generales']}" class="input-intableform form-control" id="work-${i}" name="items[${i}].work.id" from="${mgmt.work.Work.findAllByFinishedOrId(false,movementItemInstance?.work?.id,[sort:'code'])}" optionKey="id" required="" value="${movementItemInstance?.work?.id}"/></td>
					<td class="td-intableform"><g:select onchange="refreshBudgets('${i}');" class="select-chosen supplier-select form-control" id="supplier-${i}" name="items[${i}].supplier.id" from="${[movementItemInstance?.supplier]}" optionKey="id" optionValue="nameAndBusinessName" required="" value="${movementItemInstance?.supplier?.id}"/></td>
					<td class="td-intableform"><g:select onchange="refreshBudgets('${i}');" class="input-intableform form-control ${movementItemInstance.work?'conceptsWork':'conceptsNoWork'}" id="concept-${i}" name="items[${i}].concept.id" from="${[movementItemInstance?.concept]}" optionKey="id" required="" value="${movementItemInstance?.concept?.id}"/></td>
					<td class="td-intableform"><g:select class="input-intableform form-control budgets-class" id="budget-${i}" name="items[${i}].budget.id" from="${mgmt.work.SupplierBudget.createCriteria().list () {
			if(movementItemInstance.work){
				eq("work",movementItemInstance.work)
			}else{
				isNull("work")
			}
			eq("concept",movementItemInstance.concept)
			eq("supplier",movementItemInstance.supplier)
			eq("closed",false)
		}?:[[id:'null',idAndRemainingAmount:'Sin presupuesto']]}" optionKey="id" optionValue="idAndRemainingAmount" required="" value="${movementItemInstance?.budget?.id}"/></td>					
					
					<td class="td-intableform"><g:textArea cols="60" class="mayus input-intableform form-control vertical-center-aligned" name="items[${i}].description" id="description-${i}" value="${movementItemInstance?.description}"/></td>
					<td class="td-intableform"><g:select class="input-intableform form-control" id="items[${i}].invoiceType" name="items[${i}].invoiceType.id" from="${mgmt.invoice.InvoiceType.list()}" optionKey="id" required="" value="${movementItemInstance?.invoiceType?.id}"/></td>
					<td class="td-intableform"><g:textField class="input-intableform form-control" name="items[${i}].invoiceNumber" value="${movementItemInstance?.invoiceNumber}"/></td>
					<td class="td-intableform"><bs:datePicker class="input-intableform form-control center-aligned" id="date-${i}" name="items[${i}].date" precision="day"  value="${movementItemInstance?.date}"  /> </td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control autonumeric numberinput field-amount right-aligned" id="amount-${i}" name="items[${i}].amount" value="${movementItemInstance.amount}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control autonumeric numberinput field-iva right-aligned" id="iva-${i}" name="items[${i}].iva" value="${movementItemInstance.iva}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control autonumeric numberinput field-iibb right-aligned" id="iibb-${i}" name="items[${i}].iibb" value="${movementItemInstance.iibb}" required=""/></td>
					<td class="td-intableform"><g:field onchange="refreshTotal('${i}');" type="text" class="input-intableform form-control autonumeric numberinput field-otherPerceptions right-aligned" id="otherPerceptions-${i}" name="items[${i}].otherPerceptions" value="${movementItemInstance.otherPerceptions}" required=""/></td>
					<td class="td-intableform"><g:field type="text" class="autonumeric input-intableform form-control field-total right-aligned" name="items[${i}].total" id="total-${i}" value="${movementItemInstance.total}" required=""/></td>
					<td class="center-aligned"><button type="button" onclick="$('#items-${i}').remove();refreshTotals();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button><input onfocus="addItem();" type="text" style="width:0.001px; opacity: 0;" name="add-${i}" id="add-${i}"></td>
				</tr>
			</g:each>
		</tbody>
		<tbody>
			<tr class="important-bold">
				<td colspan="8">${message(code:'default.totals.label')}</td>
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
					<td class="td-intableform"><g:field type="text" onchange="refreshPaymentTotal();" class="autonumeric input-intableform form-control field-payment-amount right-aligned" name="payments[${i}].amount" value="${paymentInstance.amount}" required=""/></td>
					<td class="td-intableform"><bs:datePicker class="input-intableform form-control center-aligned" id="paymentDate-${i}" name="payments[${i}].paymentDate" precision="day"  value="${paymentInstance?.paymentDate}"  /> </td>
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
		<td class="td-intableform"><g:select disabled="disabled" class="supplier-select-model form-control" id="supplier-xyz" name="items[xyz].supplier.id" from="${mgmt.persons.Supplier.list(sort:'name')}" optionKey="id" optionValue="nameAndBusinessName" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="concept-model input-intableform form-control" id="concept-xyz" name="items[xyz].concept.id" from="${mgmt.concept.Concept.findAllByValidInOsNoWork(true,[sort:'code'])}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control budgets-class" id="budget-xyz" name="items[xyz].budget.id" from="${new ArrayList()}" noSelection="['null':'Sin presupuesto']" optionKey="id" optionValue="id" required="" value=""/></td>
		<td class="td-intableform"><g:textArea cols="60" disabled="disabled" class="mayus input-intableform form-control vertical-center-aligned" name="items[xyz].description" id="description-xyz" value=""/></td>
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" name="items[xyz].invoiceType.id" from="${mgmt.invoice.InvoiceType.list()}" optionKey="id" required="" value="${mgmt.invoice.InvoiceType.findByCode('SD')?.id}"/></td>
		<td class="td-intableform"><g:textField disabled="disabled" class="input-intableform form-control" name="items[xyz].invoiceNumber" value=""/></td>
		<td class="td-intableform"><bs:datePicker disabled="true" class="input-intableform form-control center-aligned" id="date-xyz" name="items[xyz].date" precision="day"  value=""  /> </td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput autonumeric field-amount right-aligned" id="amount-xyz" name="items[xyz].amount" value="" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput autonumeric field-iva right-aligned" id="iva-xyz" name="items[xyz].iva" value="0" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput autonumeric field-iibb right-aligned" id="iibb-xyz" name="items[xyz].iibb" value="0" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control numberinput autonumeric field-otherPerceptions right-aligned" id="otherPerceptions-xyz" name="items[xyz].otherPerceptions" value="0" required=""/></td>
		<td class="td-intableform"><g:field type="text" disabled="disabled" class="input-intableform form-control field-total autonumeric right-aligned" id="total-xyz" name="items[xyz].total" value="0" required=""/></td>
		<td class="center-aligned"><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button><input onfocus="addItem();" type="text" style="width:0.001px; opacity: 0;" name="add-xyz" id="add-xyz"></td>
	</tr>
</table>

<table>
	<tr class="form-inline" id="payment-model">
		<td class="td-intableform"><g:select disabled="disabled" class="input-intableform form-control" name="payments[xyz].account.id" from="${mgmt.account.Account.list(sort:'code')}" optionKey="id" required="" value=""/></td>
		<td class="td-intableform"><g:field type="text" onchange="refreshPaymentTotal();" disabled="disabled" class="autonumeric input-intableform form-control field-payment-amount right-aligned" name="payments[xyz].amount" value="" required=""/></td>
		<td class="td-intableform"><bs:datePicker disabled="true" class="input-intableform form-control center-aligned" id="paymentDate-xyz" name="payments[xyz].paymentDate" precision="day"  value=""  /> </td>
		<td class="td-intableform"><g:textField disabled="disabled" class="input-intableform form-control" name="payments[xyz].checkNumber" value=""/></td>
		<td class="td-intableform"><g:textField disabled="disabled" class="mayus input-intableform form-control" name="payments[xyz].note" value=""/></td>
		<td class="center-aligned"><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
	</tr>
</table>

<g:select disabled="disabled" class="input-intableform form-control" id="conceptsWork" name="conceptsWork" from="${mgmt.concept.Concept.findAllByValidInOsWork(true,[sort:'code',order:'asc'])}" optionKey="id" required="" value=""/>
<g:select disabled="disabled" class="input-intableform form-control" id="conceptsNoWork" name="conceptsNoWork" from="${mgmt.concept.Concept.findAllByValidInOsNoWork(true,[sort:'code',order:'asc'])}" optionKey="id" required="" value=""/>


</div>

<g:hiddenField name="max" value="${params.max}" />
<g:hiddenField name="sort" value="${params.sort}" />
<g:hiddenField name="order" value="${params.order}" />
<g:hiddenField name="offset" value="${params.offset}" />
<g:hiddenField name="checkedFilter" value="${params.checkedFilter}" />
<g:hiddenField name="numberFilter" value="${params.numberFilter}" />
<g:hiddenField name="yearFilter" value="${params.yearFilter}" />

<script>

var itemsQuantity = ${movementInstance?.items?.size()?:0};
var isWorkMap = new Map(); 
	
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
		refreshBudgets(currentItemQuantity);
	});
	$(".supplier-select-model", $tmc).change(function() {
		refreshBudgets(currentItemQuantity);
	});
	$(".concept-model", $tmc).change(function() {
		refreshBudgets(currentItemQuantity);
	});
	$(".deleteButton", $tmc).click(function() {
		$('#items-'+currentItemQuantity).remove();
		refreshTotals();
	});
	
	$tmc.appendTo("#items-table");
	itemsQuantity = itemsQuantity + 1;
	$('.autonumeric',$tmc).autoNumeric('init',autoNumericOptions);
	$('#supplier-'+currentItemQuantity).chosen({search_contains: true, width: "200px"});
}

var paymentsQuantity = ${movementInstance?.payments?.size()?:0};
var globalTotal = 0;

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
		$(".field-payment-amount",$tmc).val(safeParseFloat($("#total-total").text()));
	}
	
	paymentsQuantity = paymentsQuantity + 1;
	$('.autonumeric',$tmc).autoNumeric('init',autoNumericOptions);
	refreshPaymentTotal();
}

function refreshTotal(idx){
	var total = safeParseFloat($('#amount-'+idx).val())+ safeParseFloat($('#iva-'+idx).val()) + safeParseFloat($('#iibb-'+idx).val()) + safeParseFloat($('#otherPerceptions-'+idx).val());
	$('#total-'+idx).autoNumeric('set',total);
	refreshTotals();
}

function refreshTotals(){
	var amount = 0;
	$(".field-amount" ).each(function( index ) {
		amount = amount + safeParseFloat($(this ).val());
	});
	$('#total-amount').text(thousandSep(amount.toFixed(2)));
	var iva = 0;
	$(".field-iva" ).each(function( index ) {
		iva = iva + safeParseFloat($(this ).val());
	});
	$('#total-iva').text(thousandSep(iva.toFixed(2)));
	var iibb = 0;
	$(".field-iibb" ).each(function( index ) {
		iibb = iibb + safeParseFloat($(this ).val());
	});
	$('#total-iibb').text(thousandSep(iibb.toFixed(2)));
	var otherPerceptions = 0;
	$(".field-otherPerceptions" ).each(function( index ) {
		otherPerceptions = otherPerceptions + safeParseFloat($(this ).val());
	});
	$('#total-otherPerceptions').text(thousandSep(otherPerceptions.toFixed(2)));
	var total = 0;
	$(".field-total" ).each(function( index ) {
		total = total + safeParseFloat($(this ).val());
	});
	$('#total-total').text(thousandSep(total.toFixed(2)));
}
function refreshPaymentTotal(){
	var total = 0;
	$(".field-payment-amount" ).each(function( index ) {
		total = total + safeParseFloat($(this ).val());
	});
	$('#total-payment-amount').text(thousandSep(total.toFixed(2)));
}

function refreshConcepts(idx){
	hasWorkMap = isWorkMap.has(idx);
	isWork = isWorkMap.get(idx);
	
	if($('#work-'+idx).val()=='null'){
		if(!hasWorkMap || isWork){
			isWorkMap.set(idx,false);
			$('#concept-'+idx).empty().append($("#conceptsNoWork > option").clone());
		}
	}else{
		if(!hasWorkMap || !isWork){
			isWorkMap.set(idx,true);
			$('#concept-'+idx).empty().append($("#conceptsWork > option").clone());
		}
	}
}

function refreshBudgets(idx){
	var workId = $('#work-'+idx).val()
	var supplierId = $('#supplier-'+idx).val()
	var conceptId = $('#concept-'+idx).val()

	if(workId!='null' && supplierId != 'null' && conceptId != 'null'){
		
		var url = '${g.createLink(action:'retrieveBudgets')}?workId='+workId + '&conceptId='+conceptId + '&supplierId=' + supplierId
		
		$.get( url, function( data ) {
  			$( "#budget-"+idx ).html( data );
		});
		
	}
}

$(function() {
	$('.supplier-select').append($(".supplier-select-model > option").clone());
	$('.conceptsWork').append($("#conceptsWork > option").clone());
	$('.conceptsNoWork').append($("#conceptsNoWork > option").clone());
	$(".select-chosen").chosen({search_contains: true, width: "200px"});
	if(itemsQuantity == 0){
		addItem();
	}
	$('#items .autonumeric').autoNumeric('init',autoNumericOptions);
	refreshTotals();
	refreshPaymentTotal();

	$('input[type="submit"]').click(function( event ) {
		if($('#total-total').text() != $('#total-payment-amount').text()){
			alert('${message(code:'movement.amountsNotEqual.error')}');
			event.preventDefault();
			return;
		}

		var dateFromMillis = ${mgmt.config.Parameter.findByCode("FECHA_DESDE").asDate().getTime()};
		var dateToMillis = ${mgmt.config.Parameter.findByCode("FECHA_HASTA").asDate().getTime()};
		var paymentDateFromMillis = ${mgmt.config.Parameter.findByCode("FECHA_PAGO_DESDE").asDate().getTime()};
		var paymentDateToMillis = ${mgmt.config.Parameter.findByCode("FECHA_PAGO_HASTA").asDate().getTime()};
				
		var sinPresupuesto = false;
		for (i = 0; i < itemsQuantity; i++) {
			if($('#date-'+i).length  > 0 ){
	    		if($('#budget-'+i).val() == 'null' && $('#work-'+i).val() != 'null'){
	    			sinPresupuesto = true;
	    		}
	    		
	    		var dateMillis = $('#date-'+i).datepicker('getDate').getTime();  
	    		if(dateMillis > dateToMillis || dateMillis < dateFromMillis){
	    			alert('${message(code:'movementItem.dateOutOfRange.save.message')}');
					event.preventDefault();
					return;
	    		}
    		
	    		if($('#description-'+i).val().toUpperCase().includes('IVA') && safeParseFloat($('#amount-'+i).val())>0 ){
	    			alert('Si la descripción de un item contiene "iva", el neto debe ser cero.');
	    			event.preventDefault();
	    			return;
	    		}
    		}
		}
		
		for (i = 0; i < paymentsQuantity; i++) {
			if($('#paymentDate-'+i).length  > 0 ){
	    		var paymentDateMillis = $('#paymentDate-'+i).datepicker('getDate').getTime();  
	    		if(paymentDateMillis > paymentDateToMillis || paymentDateMillis < paymentDateFromMillis){
	    			alert('${message(code:'payment.dateOutOfRange.save.message')}');
					event.preventDefault();
					return;
	    		}
    		}	
		}
		
		if(sinPresupuesto && prompt('Existen ítems sin presupuesto. Ingrese clave para continuar:') != '${mgmt.config.Parameter.findByCode("CLAVE_PRESUPUESTO").value}'){
			alert("Clave inválida");
			event.preventDefault();
			return;
		}
		
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
		
				
		$(".autonumeric" ).each(function( index ) {
			$(this).val($(this).val().replace(/\./g, '').replace(/,/g,'.'));
		});

	});

	for (i = 0; i < itemsQuantity; i++) {
		if($('#work-'+i).val()=='null'){
			isWorkMap.set(i.toString(),false);
		
		}else{
			isWorkMap.set(i.toString(),true);
		}
	}

});

</script>

<g:if test="${movementInstance.checked}">
	<script>
		$(function() {
			$(".form-horizontal :input").prop('disabled', true);
			$(".form-horizontal :submit").hide();
		});
	</script>
</g:if>