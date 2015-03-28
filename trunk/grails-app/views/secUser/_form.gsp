<%@ page import="mgmt.security.SecUser" %>


			<div class="${hasErrors(bean: secUserInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="secUser.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${secUserInstance?.name}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: secUserInstance, field: 'username', 'has-error')} required">
				<label for="username" class="control-label"><g:message code="secUser.username.label" default="Username" /><span class="required-indicator">*</span></label>
				<div>
					<g:textField class="form-control" name="username" required="" value="${secUserInstance?.username}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: secUserInstance, field: 'password', 'has-error')} required">
				<label for="password" class="control-label"><g:message code="secUser.password.label" default="Password" /><span class="required-indicator">*</span></label>
				<div>
					<input type="password" class="form-control" name="${secUserInstance.password?'newPassword':'password'}" ${secUserInstance.password?'':'required'} />
				</div>
			</div>
			<div>
				<label for="authorities" class="control-label"><g:message code="secUser.authorities.label" /></label>
				<div>
					<g:select class="form-control" id="authorities" name="authorities" from="${mgmt.security.SecAuthority.list()}" optionKey="id" multiple="multiple" value="${params.action=='edit'?secUserInstance.authorities*.id:null}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: secUserInstance, field: 'accountExpired', 'has-error')} ">
				<label for="accountExpired" class="control-label"><g:message code="secUser.accountExpired.label" default="Account Expired" /></label>
				<div>
					<g:checkBox name="accountExpired" value="${secUserInstance?.accountExpired}" />
				</div>
			</div>

			<div class="${hasErrors(bean: secUserInstance, field: 'accountLocked', 'has-error')} ">
				<label for="accountLocked" class="control-label"><g:message code="secUser.accountLocked.label" default="Account Locked" /></label>
				<div>
					<g:checkBox name="accountLocked" value="${secUserInstance?.accountLocked}" />
				</div>
			</div>

			<div class="${hasErrors(bean: secUserInstance, field: 'enabled', 'has-error')} ">
				<label for="enabled" class="control-label"><g:message code="secUser.enabled.label" default="Enabled" /></label>
				<div>
					<g:checkBox name="enabled" value="${secUserInstance?.enabled}" />
				</div>
			</div>


			<div class="${hasErrors(bean: secUserInstance, field: 'passwordExpired', 'has-error')} ">
				<label for="passwordExpired" class="control-label"><g:message code="secUser.passwordExpired.label" default="Password Expired" /></label>
				<div>
					<g:checkBox name="passwordExpired" value="${secUserInstance?.passwordExpired}" />
				</div>
			</div>
