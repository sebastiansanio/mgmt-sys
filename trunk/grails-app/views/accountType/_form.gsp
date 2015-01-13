<%@ page import="mgmt.account.AccountType" %>



<div class="col-md-3 ${hasErrors(bean: accountTypeInstance, field: 'name', 'has-error')} ">
	<label for="name" class="control-label"><g:message code="accountType.name.label" default="Name" /></label>
	<div>
		<g:textField class="form-control" name="name" value="${accountTypeInstance?.name}"/>
	</div>
</div>
