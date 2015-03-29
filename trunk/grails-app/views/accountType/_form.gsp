<%@ page import="mgmt.account.AccountType" %>



<div ${hasErrors(bean: accountTypeInstance, field: 'name', 'has-error')} ">
	<label for="name" class="control-label"><g:message code="accountType.name.label" default="Name" /></label>
	<div>
		<g:textField class="mayus form-control" name="name" value="${accountTypeInstance?.name}"/>
	</div>
</div>

<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	
	});
</script>