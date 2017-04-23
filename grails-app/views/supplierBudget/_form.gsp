<%@ page import="mgmt.work.SupplierBudget" %>

<div class="container-fluid">

<div class="col-md-6">
<g:if test="${supplierBudgetInstance.id}">

<label for="id" class="control-label">
<g:message code="supplierBudget.id.label"  />
</label>
<div>${supplierBudgetInstance?.id}</div>
</g:if>			

<div class="${hasErrors(bean: supplierBudgetInstance, field: 'supplier', 'has-error')} required">
	<label for="supplier" class="control-label"><g:message code="supplierBudget.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
	<div>
		<g:if test="${supplierBudgetInstance.movementItems}">
			${supplierBudgetInstance?.supplier}
		</g:if>
		<g:else>
			<g:select class="select-chosen form-control" id="supplier" name="supplier.id" from="${mgmt.persons.Supplier.list()}" optionKey="id" required="" value="${supplierBudgetInstance?.supplier?.id}"/>
		</g:else>
	</div>
</div>

<div class="${hasErrors(bean: supplierBudgetInstance, field: 'work', 'has-error')} required">
	<label for="work" class="control-label"><g:message code="supplierBudget.work.label" default="Work" /><span class="required-indicator">*</span></label>
	<div>
		<g:if test="${supplierBudgetInstance.movementItems}">
			${supplierBudgetInstance?.work}
		</g:if>
		<g:else>
			<g:select onchange="refreshConcepts();" noSelection="${['null':'00 - Gastos generales']}" class="form-control" id="work" name="work.id" from="${mgmt.work.Work.findAllByFinished(false,[sort: 'code'])}" optionKey="id" required="" value="${supplierBudgetInstance?.work?.id}"/>
		</g:else>
	</div>
</div>
<div class="${hasErrors(bean: supplierBudgetInstance, field: 'concept', 'has-error')} required">
	<label for="concept" class="control-label"><g:message code="supplierBudget.concept.label" default="Concept" /><span class="required-indicator">*</span></label>
	<div>
		<g:if test="${supplierBudgetInstance.movementItems}">
			${supplierBudgetInstance?.concept}
		</g:if>
		<g:else>
			<g:select class="form-control" id="concept" name="concept.id" from="${mgmt.concept.Concept.list()}" optionKey="id" required="" value="${supplierBudgetInstance?.concept?.id}"/>
		</g:else>
	</div>
</div>
<div class="${hasErrors(bean: supplierBudgetInstance, field: 'amount', 'has-error')} required">
	<label for="amount" class="control-label"><g:message code="supplierBudget.amount.label" default="Amount" /><span class="required-indicator">*</span><g:if test="${supplierBudgetInstance.id}"> (Min: ${supplierBudgetInstance.realExpendures.expendedAmount}) </g:if></label>
	<div>
		<g:field type="text" class="changeTotals autonumeric form-control" name="amount" value="${supplierBudgetInstance.amount}" required=""/>
	</div>
</div>

<div class="${hasErrors(bean: supplierBudgetInstance, field: 'iva', 'has-error')} required">
	<label for="iva" class="control-label"><g:message code="supplierBudget.iva.label" default="Iva" /><span class="required-indicator">* </span><g:if test="${supplierBudgetInstance.id}">(Min: ${supplierBudgetInstance.realExpendures.expendedIva}) </g:if></label>
	<div>
		<g:field type="text" class="changeTotals autonumeric form-control" name="iva" value="${supplierBudgetInstance.iva}" required=""/>
	</div>
</div>

<div class="${hasErrors(bean: supplierBudgetInstance, field: 'invoiceType', 'has-error')} required">
	<label for="work" class="control-label"><g:message code="supplierBudget.invoiceType.label" /><span class="required-indicator">*</span></label>
	<div>
		<g:select noSelection="${['null':'Sin selección']}" class="form-control" id="invoiceType" name="invoiceType.id" from="${mgmt.invoice.InvoiceType.list()}" optionKey="id" required="" value="${supplierBudgetInstance?.invoiceType?.id}"/>
	</div>
</div>

<div class="${hasErrors(bean: supplierBudgetInstance, field: 'note', 'has-error')} ">
	<label for="note" class="control-label"><g:message code="supplierBudget.note.label" default="Note" /></label>
	<div>
		<g:textArea class="mayus form-control" name="note" cols="40" rows="5" maxlength="4000" value="${supplierBudgetInstance?.note}"/>
	</div>
</div>
			
			
<div class="hide" >	
	<g:select disabled="disabled" class="input-intableform form-control" id="conceptsWork" name="conceptsWork" from="${mgmt.concept.Concept.findAllByValidInOpWork(true,[sort:'code',order:'asc'])}" optionKey="id" required="" value=""/>
	<g:select disabled="disabled" class="input-intableform form-control" id="conceptsNoWork" name="conceptsNoWork" from="${mgmt.concept.Concept.findAllByValidInOpNoWork(true,[sort:'code',order:'asc'])}" optionKey="id" required="" value=""/>
</div>			
		
</div>	

<div class="col-md-6">	
<h4><g:message code="supplierBudget.items.label" /></h4>
<div id="items" class="table-responsive">

	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th class="center-aligned vertical-center-aligned">${message(code: 'supplierBudgetItem.description.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'supplierBudgetItem.amount.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'supplierBudgetItem.iva.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'default.button.delete.label')}</th>
			</tr>
		</thead>
		<tbody id="items-table">
			<g:each var="supplierBudgetItem" in="${supplierBudgetInstance?.items}" status="i">
				<tr class="form-inline" id="items-${i}">
					<td class="td-intableform"><g:field type="text" class="input-intableform form-control" id="description-${i}" name="items[${i}].description" value="${supplierBudgetItem.description}"/></td>
					<td class="td-intableform"><g:field type="text" class="changeTotals input-intableform form-control autonumeric right-aligned field-amount" id="amount-${i}" name="items[${i}].amount" value="${supplierBudgetItem.amount}" required=""/></td>
					<td class="td-intableform"><g:field type="text" class="changeTotals input-intableform form-control autonumeric right-aligned field-iva" id="iva-${i}" name="items[${i}].iva" value="${supplierBudgetItem.iva}" required=""/></td>
					<td class="center-aligned"><button type="button" onclick="$('#items-${i}').remove();refreshTotals();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
				
				</tr>
			</g:each>
		</tbody>
		<tbody>
			<tr class="important-bold">
				<td>Subtotal</td>
				<td class="right-aligned" id="subtotal-amount"></td>
				<td class="right-aligned" id="subtotal-iva"></td>
			</tr>
			<tr class="important-bold">
				<td>Total</td>
				<td class="right-aligned" id="total-amount"></td>
				<td class="right-aligned" id="total-iva"></td>
			</tr>
		</tbody>
	</table>

</div>	
<button type="button" class="btn btn-default" onclick="addItem();" >Agregar item</button>
</div>	
</div>

<div class="hide" >
<table>
	<tr class="form-inline" id="item-model">
		<td class="td-intableform"><g:field disabled="disabled" type="text" class="input-intableform form-control" id="description-xyz" name="items[xyz].description" value=""/></td>
		<td class="td-intableform"><g:field disabled="disabled" type="text" class="changeTotals input-intableform form-control autonumeric right-aligned field-amount" id="amount-xyz" name="items[xyz].amount" value="" required=""/></td>
		<td class="td-intableform"><g:field disabled="disabled" type="text" class="changeTotals input-intableform form-control autonumeric right-aligned field-iva" id="iva-xyz" name="items[xyz].iva" value="" required=""/></td>
		<td class="center-aligned"><button type="button" class="deleteButton" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td>
		
	</tr>
</table>
</div>

<script>

var itemsQuantity = ${supplierBudgetInstance?.items?.size()?:0};

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
	$('.changeTotals',$tmc).change(function( event ) {
		refreshTotals();
	});
	
	$tmc.appendTo("#items-table");
	itemsQuantity = itemsQuantity + 1;
	$('.autonumeric',$tmc).autoNumeric('init',autoNumericOptions);
}


$(function() {
	$(".select-chosen").chosen();
	$('.autonumeric').autoNumeric('init',autoNumericOptions);
	refreshConcepts();

	$('input[type="submit"]').click(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});

		$(".autonumeric" ).each(function( index ) {
			$(this).val($(this).val().replace(/\./g, '').replace(/,/g,'.'));
		});

	});


	$('.changeTotals').change(function( event ) {
		refreshTotals();
	});
	refreshTotals();
	
});

function refreshTotals(){
	var amount = 0;
	$(".field-amount" ).each(function( index ) {
		amount = amount + safeParseFloat($(this ).val());
	});
	$('#subtotal-amount').text(thousandSep(amount.toFixed(2)));
	var iva = 0;
	$(".field-iva" ).each(function( index ) {
		iva = iva + safeParseFloat($(this ).val());
	});
	$('#subtotal-iva').text(thousandSep(iva.toFixed(2)));

	totalAmount = amount + safeParseFloat($("#amount").val());
	totalIva = iva + safeParseFloat($("#iva").val());
	$('#total-amount').text(thousandSep(totalAmount.toFixed(2)));
	$('#total-iva').text(thousandSep(totalIva.toFixed(2)));
}

function refreshConcepts(){
	if($('#work').val()=='null'){
		$('#concept').empty().append($("#conceptsNoWork > option").clone());
	}else{
		$('#concept').empty().append($("#conceptsWork > option").clone());
	}
}



</script>	