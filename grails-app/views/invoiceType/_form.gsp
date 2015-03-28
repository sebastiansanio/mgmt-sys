<%@ page import="mgmt.invoice.InvoiceType" %>



			<div class="${hasErrors(bean: invoiceTypeInstance, field: 'code', 'has-error')} ">
				<label for="code" class="control-label"><g:message code="invoiceType.code.label" default="Code" /></label>
				<div>
					<g:textField class="form-control" name="code" value="${invoiceTypeInstance?.code}"/>
				</div>
			</div>
