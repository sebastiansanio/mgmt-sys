<%@ page import="mgmt.concept.ConceptGroup" %>



			<div class="${hasErrors(bean: conceptGroupInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="conceptGroup.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${conceptGroupInstance?.name}"/>
				</div>
			</div>
