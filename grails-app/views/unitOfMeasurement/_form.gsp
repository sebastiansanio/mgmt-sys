<%@ page import="mgmt.products.UnitOfMeasurement" %>



			<div class="${hasErrors(bean: unitOfMeasurementInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="unitOfMeasurement.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${unitOfMeasurementInstance?.name}"/>
				</div>
			</div>
