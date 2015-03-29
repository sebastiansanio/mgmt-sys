<%@ page import="mgmt.security.SecAuthority" %>



			<div class="${hasErrors(bean: secAuthorityInstance, field: 'authority', 'has-error')} required">
				<label for="authority" class="control-label"><g:message code="secAuthority.authority.label" default="Authority" /><span class="required-indicator">*</span></label>
				<div>
					<g:textField class="form-control" name="authority" required="" value="${secAuthorityInstance?.authority}"/>
				</div>
			</div>
