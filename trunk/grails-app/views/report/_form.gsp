<%@ page import="mgmt.reports.Report" %>


			<div class="${hasErrors(bean: reportInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="report.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${reportInstance?.name}"/>
				</div>
			</div>
			
			<div class="${hasErrors(bean: reportInstance, field: 'code', 'has-error')} ">
				<label for="code" class="control-label"><g:message code="report.code.label" /></label>
				<div>
					<g:field type="text" class="form-control" name="code" maxlength="255" value="${reportInstance?.code}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: reportInstance, field: 'variables', 'has-error')} ">
				<label for="variables" class="control-label"><g:message code="report.variables.label" default="Variables" /></label>
				<div>
					<g:textArea class="form-control" name="variables" cols="40" rows="5" maxlength="4000" value="${reportInstance?.variables}"/>
				</div>
			</div>
			<div class="${hasErrors(bean: reportInstance, field: 'definition', 'has-error')} required">
				<label for="definition" class="control-label"><g:message code="report.definition.label" default="Definition" /><span class="required-indicator">*</span></label>
				<div>
					<input type="file" id="definition" name="definition" />
				</div>
			</div>


