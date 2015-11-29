<%@ page import="mgmt.work.SupplierBudget" %>

			<div class="${hasErrors(bean: supplierBudgetInstance, field: 'supplier', 'has-error')} required">
				<label for="supplier" class="control-label"><g:message code="supplierBudget.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="select-chosen form-control" id="supplier" name="supplier.id" from="${mgmt.persons.Supplier.list()}" optionKey="id" required="" value="${supplierBudgetInstance?.supplier?.id}"/>
				</div>
			</div>
			
			<div class="${hasErrors(bean: supplierBudgetInstance, field: 'concept', 'has-error')} required">
				<label for="concept" class="control-label"><g:message code="supplierBudget.concept.label" default="Concept" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="concept" name="concept.id" from="${mgmt.concept.Concept.list()}" optionKey="id" required="" value="${supplierBudgetInstance?.concept?.id}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierBudgetInstance, field: 'amount', 'has-error')} required">
				<label for="amount" class="control-label"><g:message code="supplierBudget.amount.label" default="Amount" /><span class="required-indicator">*</span></label>
				<div>
					<g:field type="text" class="form-control" name="amount" value="${fieldValue(bean: supplierBudgetInstance, field: 'amount')}" required=""/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierBudgetInstance, field: 'iva', 'has-error')} required">
				<label for="iva" class="control-label"><g:message code="supplierBudget.iva.label" default="Iva" /><span class="required-indicator">*</span></label>
				<div>
					<g:field type="text" class="form-control" name="iva" value="${fieldValue(bean: supplierBudgetInstance, field: 'iva')}" required=""/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierBudgetInstance, field: 'work', 'has-error')} required">
				<label for="work" class="control-label"><g:message code="supplierBudget.work.label" default="Work" /><span class="required-indicator">*</span></label>
				<div>
					<g:select noSelection="${['null':'00 - Gastos generales']}" class="form-control" id="work" name="work.id" from="${mgmt.work.Work.findAllByFinished(false)}" optionKey="id" required="" value="${supplierBudgetInstance?.work?.id}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierBudgetInstance, field: 'note', 'has-error')} ">
				<label for="note" class="control-label"><g:message code="supplierBudget.note.label" default="Note" /></label>
				<div>
					<g:textArea class="mayus form-control" name="note" cols="40" rows="5" maxlength="4000" value="${supplierBudgetInstance?.note}"/>
				</div>
			</div>
			
			
<script>

$(function() {
	$(".select-chosen").chosen();
});

$("form").submit(function( event ) {
	$(".mayus" ).each(function( index ) {
		$(this).val($(this).val().toUpperCase());
	});

});

</script>	