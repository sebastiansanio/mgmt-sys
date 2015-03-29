<%@ page import="mgmt.account.Account" %>



			<div class="${hasErrors(bean: accountInstance, field: 'code', 'has-error')} ">
				<label for="code" class="control-label"><g:message code="account.code.label" default="Code" /></label>
				<div>
					<g:textField class="form-control" name="code" value="${accountInstance?.code}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: accountInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="account.name.label" default="Name" /></label>
				<div>
					<g:textField class="mayus form-control" name="name" value="${accountInstance?.name}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: accountInstance, field: 'type', 'has-error')} required">
				<label for="type" class="control-label"><g:message code="account.type.label" default="Type" /><span class="required-indicator">*</span></label>
				<div>
					<g:select class="form-control" id="type" name="type.id" from="${mgmt.account.AccountType.list()}" optionKey="id" required="" value="${accountInstance?.type?.id}"/>
				</div>
			</div>

			
<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	
	});
</script>