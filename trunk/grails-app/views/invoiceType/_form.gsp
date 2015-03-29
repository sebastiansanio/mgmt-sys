<%@ page import="mgmt.invoice.InvoiceType" %>



			<div class="${hasErrors(bean: invoiceTypeInstance, field: 'code', 'has-error')} ">
				<label for="code" class="control-label"><g:message code="invoiceType.code.label" default="Code" /></label>
				<div>
					<g:textField class="mayus form-control" name="code" value="${invoiceTypeInstance?.code}"/>
				</div>
			</div>

<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	
	});
</script>