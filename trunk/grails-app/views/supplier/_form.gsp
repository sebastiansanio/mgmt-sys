<%@ page import="mgmt.persons.Supplier" %>



			<div class="${hasErrors(bean: supplierInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="supplier.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${supplierInstance?.name}"/>
				</div>
			</div>
			
			<div class="${hasErrors(bean: supplierInstance, field: 'cuit', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="supplier.cuit.label" default="Cuit" /></label>
				<div>
					<g:textField class="form-control" name="cuit" value="${supplierInstance?.cuit}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'address', 'has-error')} ">
				<label for="address" class="control-label"><g:message code="supplier.address.label" default="Address" /></label>
				<div>
					<g:textField class="form-control" name="address" value="${supplierInstance?.address}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'location', 'has-error')} ">
				<label for="location" class="control-label"><g:message code="supplier.location.label" default="Location" /></label>
				<div>
					<g:textField class="form-control" name="location" value="${supplierInstance?.location}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'note', 'has-error')} ">
				<label for="note" class="control-label"><g:message code="supplier.note.label" default="Note" /></label>
				<div>
					<g:textField class="form-control" name="note" value="${supplierInstance?.note}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'province', 'has-error')} ">
				<label for="province" class="control-label"><g:message code="supplier.province.label" default="Province" /></label>
				<div>
					<g:textField class="form-control" name="province" value="${supplierInstance?.province}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'zipCode', 'has-error')} ">
				<label for="zipCode" class="control-label"><g:message code="supplier.zipCode.label" default="Zip Code" /></label>
				<div>
					<g:textField class="form-control" name="zipCode" value="${supplierInstance?.zipCode}"/>
				</div>
			</div>
