<%@ page import="mgmt.procurement.Invoice" %>



			<div class="${hasErrors(bean: invoiceInstance, field: 'description', 'error')} ">
				<label for="description" class="control-label"><g:message code="invoice.description.label" default="Description" /></label>
				<div>
					<g:textField class="form-control" name="description" value="${invoiceInstance?.description}"/>
					<span class="help-inline">${hasErrors(bean: invoiceInstance, field: 'description', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: invoiceInstance, field: 'number', 'error')} required">
				<label for="number" class="control-label"><g:message code="invoice.number.label" default="Number" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="number" type="number" value="${invoiceInstance.number}" required=""/>
					<span class="help-inline">${hasErrors(bean: invoiceInstance, field: 'number', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: invoiceInstance, field: 'supplier', 'error')} required">
				<label for="supplier" class="control-label"><g:message code="invoice.supplier.label" default="Supplier" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="supplier" name="supplier.id" from="${mgmt.persons.Supplier.list()}" optionKey="id" required="" value="${invoiceInstance?.supplier?.id}" />
					<span class="help-inline">${hasErrors(bean: invoiceInstance, field: 'supplier', 'error')}</span>
				</div>
			</div>

