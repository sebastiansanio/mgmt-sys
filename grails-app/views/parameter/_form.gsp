<%@ page import="mgmt.config.Parameter" %>

<div class="container-fluid">

	<div class="col-md-3 ${hasErrors(bean: parameterInstance, field: 'code', 'has-error')} required">
		<label for="code" class="control-label"><g:message code="parameter.code.label" default="Code" /><span class="required-indicator">*</span></label>
		<div>
			<g:textField class="form-control" name="code" required="" value="${parameterInstance?.code}"/>
		</div>
	</div>
	
	<div class="col-md-3 ${hasErrors(bean: parameterInstance, field: 'value', 'has-error')} required">
		<label for="value" class="control-label"><g:message code="parameter.value.label" default="Value" /><span class="required-indicator">*</span></label>
		<div>
			<g:textField class="form-control" name="value" required="" value="${parameterInstance?.value}"/>
		</div>
	</div>
</div>
			