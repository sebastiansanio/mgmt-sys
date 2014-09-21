<%@ page import="mgmt.persons.Supplier" %>



			<div class="${hasErrors(bean: supplierInstance, field: 'cuit', 'error')} ">
				<label for="cuit" class="control-label"><g:message code="supplier.cuit.label" default="Cuit" /></label>
				<div>
					<g:textField class="form-control" name="cuit" value="${supplierInstance?.cuit}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'cuit', 'error')}</span>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'name', 'error')} ">
				<label for="name" class="control-label"><g:message code="supplier.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${supplierInstance?.name}"/>
					<span class="help-inline">${hasErrors(bean: supplierInstance, field: 'name', 'error')}</span>
				</div>
			</div>

