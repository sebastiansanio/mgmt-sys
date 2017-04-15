<%@ page import="mgmt.work.SupplierBudget" %>
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
	<label for="amount" class="control-label"><g:message code="supplierBudget.amount.label" default="Amount" /><span class="required-indicator">*</span></label>
	<div>
		<g:field type="text" class="autonumeric form-control" name="amount" value="${supplierBudgetInstance.amount}" required=""/>
		<g:if test="${supplierBudgetInstance.id}"> (Min: ${supplierBudgetInstance.realExpendures.expendedAmount}) </g:if>
	</div>
</div>

<div class="${hasErrors(bean: supplierBudgetInstance, field: 'iva', 'has-error')} required">
	<label for="iva" class="control-label"><g:message code="supplierBudget.iva.label" default="Iva" /><span class="required-indicator">*</span></label>
	<div>
		<g:field type="text" class="autonumeric form-control" name="iva" value="${supplierBudgetInstance.iva}" required=""/>
		<g:if test="${supplierBudgetInstance.id}">(Min: ${supplierBudgetInstance.realExpendures.expendedIva}) </g:if>
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
			
			
<script>

$(function() {
	$(".select-chosen").chosen();
	$('.autonumeric').autoNumeric('init',autoNumericOptions);
	refreshConcepts();
});

function refreshConcepts(){
	if($('#work').val()=='null'){
		$('#concept').empty().append($("#conceptsNoWork > option").clone());
	}else{
		$('#concept').empty().append($("#conceptsWork > option").clone());
	}
}

$("form").submit(function( event ) {
	$(".mayus" ).each(function( index ) {
		$(this).val($(this).val().toUpperCase());
	});

	$(".autonumeric" ).each(function( index ) {
		$(this).val($(this).val().replace(/\./g, '').replace(/,/g,'.'));
	});

});

</script>	