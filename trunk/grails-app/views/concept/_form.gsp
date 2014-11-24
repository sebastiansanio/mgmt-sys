<%@ page import="mgmt.core.Concept" %>



			<div class="${hasErrors(bean: conceptInstance, field: 'code', 'has-error')} ">
				<label for="code" class="control-label"><g:message code="concept.code.label" default="Code" /></label>
				<div>
					<g:textField class="form-control" name="code" value="${conceptInstance?.code}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: conceptInstance, field: 'description', 'has-error')} ">
				<label for="description" class="control-label"><g:message code="concept.description.label" default="Description" /></label>
				<div>
					<g:textField class="form-control" name="description" value="${conceptInstance?.description}"/>
				</div>
			</div>
