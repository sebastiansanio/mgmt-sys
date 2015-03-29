<%@ page import="mgmt.concept.ConceptAccount" %>



			<div class="${hasErrors(bean: conceptAccountInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="conceptAccount.name.label" default="Name" /></label>
				<div>
					<g:textField class="mayus form-control" name="name" value="${conceptAccountInstance?.name}"/>
				</div>
			</div>
			
<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	
	});
</script>