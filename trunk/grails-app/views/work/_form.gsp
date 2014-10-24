<%@ page import="mgmt.core.Work" %>

			<div class="${hasErrors(bean: workInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="work.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${workInstance?.name}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: workInstance, field: 'finished', 'has-error')} ">
				<label for="finished" class="control-label"><g:message code="work.finished.label" default="Finished" /></label>
				<div>
					<g:checkBox name="finished" value="${workInstance?.finished}" />
				</div>
			</div>


