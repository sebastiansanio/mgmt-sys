<%@ page import="mgmt.payment.PaymentOrder" %>


	<div class="form-inline">
		<div class="form-group">
			<div class="input-group ${hasErrors(bean: paymentOrderInstance, field: 'type', 'has-error')} ">
				<label for="type" class="control-label"><g:message code="paymentOrder.type.label" default="Type" /></label>
				<div>
					<g:select class="form-control" name="type" from="${paymentOrderInstance.constraints.type.inList}" value="${paymentOrderInstance?.type}" valueMessagePrefix="paymentOrder.type" noSelection="['': '']"/>
				</div>
			</div>
	
			<div class="input-group ${hasErrors(bean: paymentOrderInstance, field: 'number', 'has-error')} required">
				<label for="number" class="control-label"><g:message code="paymentOrder.number.label" default="Number" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="number" type="number" value="${paymentOrderInstance.number}" required=""/>
				</div>
			</div>
	
			<div class="input-group ${hasErrors(bean: paymentOrderInstance, field: 'date', 'has-error')} required">
				<label for="date" class="control-label"><g:message code="paymentOrder.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker class="form-control" name="date" precision="day"  value="${paymentOrderInstance?.date}"  />
				</div>
			</div>
		</div>
	</div>

<div id="items">
	<table class="table table-condensed">
		<thead>
			<tr>
				<th>${message(code: 'paymentOrderItem.work.label')}</th>
				<th>${message(code: 'paymentOrderItem.supplier.label')}</th>
				<th>${message(code: 'paymentOrderItem.concept.label')}</th>
				<th>${message(code: 'paymentOrderItem.description.label')}</th>
				<th>${message(code: 'paymentOrderItem.invoiceType.label')}</th>
				<th>${message(code: 'paymentOrderItem.invoiceNumber.label')}</th>
				<th>${message(code: 'paymentOrderItem.amount.label')}</th>
				<th>${message(code: 'paymentOrderItem.iva.label')}</th>
				<th>${message(code: 'paymentOrderItem.iibb.label')}</th>
				<th>${message(code: 'paymentOrderItem.total.label')}</th>
			</tr>
		</thead>
		<tbody id="items-table">
			<g:each var="paymentOrderItemInstance" in="${paymentOrderInstance?.items}" status="i">
				<tr class="form-inline">
					<td><g:select class="form-control" id="items[${i}].work" name="items[${i}].work.id" from="${mgmt.work.Work.list()}" optionKey="id" required="" value="${paymentOrderItemInstance?.work?.id}"/></td>
					<td><g:select class="form-control" id="items[${i}].supplier" name="items[${i}].supplier.id" from="${mgmt.persons.Supplier.list()}" optionKey="id" required="" value="${paymentOrderItemInstance?.supplier?.id}"/></td>
					<td><g:select class="form-control" id="items[${i}].concept" name="items[${i}].concept.id" from="${mgmt.concept.Concept.list()}" optionKey="id" required="" value="${paymentOrderItemInstance?.concept?.id}"/></td>
					<td><g:textField class="form-control" name="items[${i}].description" value="${paymentOrderItemInstance?.description}"/></td>
					<td><g:select class="form-control" id="items[${i}].invoiceType" name="items[${i}].invoiceType.id" from="${mgmt.payment.InvoiceType.list()}" optionKey="id" required="" value="${paymentOrderItemInstance?.invoiceType?.id}"/></td>
					<td><g:textField class="form-control" name="items[${i}].invoiceNumber" value="${paymentOrderItemInstance?.invoiceNumber}"/></td>
					<td><g:field class="form-control" name="items[${i}].amount" value="${fieldValue(bean: paymentOrderItemInstance, field: 'amount')}" required=""/></td>
					<td><g:field class="form-control" name="items[${i}].iva" value="${fieldValue(bean: paymentOrderItemInstance, field: 'iva')}" required=""/></td>
					<td><g:field class="form-control" name="items[${i}].iibb" value="${fieldValue(bean: paymentOrderItemInstance, field: 'iibb')}" required=""/></td>
					<td><g:field class="form-control" name="items[${i}].total" value="${fieldValue(bean: paymentOrderItemInstance, field: 'total')}" required=""/></td>
				</tr>
			</g:each>
		</tbody>
	</table>
	
</div>

<button type="button" class="btn btn-default" onclick="addItem();" >Agregar item</button>
<div class="hide" >
<table>
	<tr class="form-inline" id="item-model">
		<td><g:select disabled="disabled" class="form-control" name="items[xyz].work.id" from="${mgmt.work.Work.list()}" optionKey="id" required="" value=""/></td>
		<td><g:select disabled="disabled" class="form-control" name="items[xyz].supplier.id" from="${mgmt.persons.Supplier.list()}" optionKey="id" required="" value=""/></td>
		<td><g:select disabled="disabled" class="form-control" name="items[xyz].concept.id" from="${mgmt.concept.Concept.list()}" optionKey="id" required="" value=""/></td>
		<td><g:textField disabled="disabled" class="form-control" name="items[xyz].description" value=""/></td>
		<td><g:select disabled="disabled" class="form-control" name="items[xyz].invoiceType.id" from="${mgmt.payment.InvoiceType.list()}" optionKey="id" required="" value=""/></td>
		<td><g:textField disabled="disabled" class="form-control" name="items[xyz].invoiceNumber" value=""/></td>
		<td><g:field disabled="disabled" class="form-control" name="items[xyz].amount" value="" required=""/></td>
		<td><g:field disabled="disabled" class="form-control" name="items[xyz].iva" value="" required=""/></td>
		<td><g:field disabled="disabled" class="form-control" name="items[xyz].iibb" value="" required=""/></td>
		<td><g:field disabled="disabled" class="form-control" name="items[xyz].total" value="" required=""/></td>
	</tr>
</table>
</div>

<script>

var itemsQuantity = ${paymentOrderInstance?.items?.size()?:0};
	
function addItem(){
	$tmc = $("#item-model").clone();
	$tmc.removeAttr('id');
	$("input", $tmc).each(function(){
		$(this).attr('name',$(this).attr('name').replace('xyz',itemsQuantity));
		$(this).attr('id',$(this).attr('id').replace('xyz',itemsQuantity));		
		$(this).prop("disabled", false);
	});
	$("select", $tmc).each(function(){
		$(this).attr('name',$(this).attr('name').replace('xyz',itemsQuantity));	
		$(this).attr('id',$(this).attr('id').replace('xyz',itemsQuantity));	
		$(this).prop("disabled", false);
	});
	
	$tmc.appendTo("#items-table");
	itemsQuantity = itemsQuantity + 1;
	
}

</script>

