<%@ page import="mgmt.payment.Invoice" %>



			<div class="${hasErrors(bean: invoiceInstance, field: 'date', 'error')} required">
				<label for="date" class="control-label"><g:message code="invoice.date.label" default="Date" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker class="form-control" name="date" precision="day"  value="${invoiceInstance?.date}"  />
					<span class="help-inline">${hasErrors(bean: invoiceInstance, field: 'date', 'error')}</span>
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
					<g:select class="form-control" id="supplier" name="supplier.id" from="${mgmt.persons.Supplier.list()}" optionKey="id" required="" value="${invoiceInstance?.supplier?.id}"/>
					<span class="help-inline">${hasErrors(bean: invoiceInstance, field: 'supplier', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: invoiceInstance, field: 'type', 'error')} required">
				<label for="type" class="control-label"><g:message code="invoice.type.label" default="Type" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="type" name="type.id" from="${mgmt.payment.InvoiceType.list()}" optionKey="id" required="" value="${invoiceInstance?.type?.id}"/>
					<span class="help-inline">${hasErrors(bean: invoiceInstance, field: 'type', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: invoiceInstance, field: 'work', 'error')} required">
				<label for="work" class="control-label"><g:message code="invoice.work.label" default="Work" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="work" name="work.id" from="${mgmt.core.Work.list()}" optionKey="id" required="" value="${invoiceInstance?.work?.id}"/>
					<span class="help-inline">${hasErrors(bean: invoiceInstance, field: 'work', 'error')}</span>
				</div>
			</div>
