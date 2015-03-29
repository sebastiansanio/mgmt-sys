<%@ page import="mgmt.security.Requestmap" %>



			<div class="${hasErrors(bean: requestmapInstance, field: 'url', 'has-error')} required">
				<label for="url" class="control-label"><g:message code="requestmap.url.label" default="Url" /><span class="required-indicator">*</span></label>
				<div>
					<g:textField class="form-control" name="url" required="" value="${requestmapInstance?.url}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: requestmapInstance, field: 'configAttribute', 'has-error')} required">
				<label for="configAttribute" class="control-label"><g:message code="requestmap.configAttribute.label" default="Config Attribute" /><span class="required-indicator">*</span></label>
				<div>
					<g:textField class="form-control" name="configAttribute" required="" value="${requestmapInstance?.configAttribute}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: requestmapInstance, field: 'httpMethod', 'has-error')} ">
				<label for="httpMethod" class="control-label"><g:message code="requestmap.httpMethod.label" default="Http Method" /></label>
				<div>
					<g:select class="form-control" name="httpMethod" from="${org.springframework.http.HttpMethod?.values()}" keys="${org.springframework.http.HttpMethod.values()*.name()}" value="${requestmapInstance?.httpMethod?.name()}" noSelection="['': '']"/>
				</div>
			</div>
