<%@ page import="mgmt.persons.Client" %>

			<div class="${hasErrors(bean: clientInstance, field: 'businessName', 'has-error')} ">
				<label for="businessName" class="control-label"><g:message code="client.businessName.label" default="Business Name" /></label>
				<div>
					<g:textField onchange="fillName();" class="mayus form-control" name="businessName" value="${clientInstance?.businessName}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: clientInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="client.name.label" default="Name" /></label>
				<div>
					<g:textField class="mayus form-control" name="name" value="${clientInstance?.name}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: clientInstance, field: 'cuit', 'has-error')} ">
				<label for="cuit" class="control-label"><g:message code="client.cuit.label" default="Cuit" /></label>
				<div>
					<g:textField class="form-control" name="cuit" value="${clientInstance?.cuit}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: clientInstance, field: 'address', 'has-error')} ">
				<label for="address" class="control-label"><g:message code="client.address.label" default="Address" /></label>
				<div>
					<g:textField class="mayus form-control" name="address" value="${clientInstance?.address}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: clientInstance, field: 'location', 'has-error')} ">
				<label for="location" class="control-label"><g:message code="client.location.label" default="Location" /></label>
				<div>
					<g:textField class="mayus form-control" name="location" value="${clientInstance?.location}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: clientInstance, field: 'province', 'has-error')} ">
				<label for="province" class="control-label"><g:message code="client.province.label" default="Province" /></label>
				<div>
					<g:textField class="mayus form-control" name="province" value="${clientInstance?.province}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: clientInstance, field: 'zipCode', 'has-error')} ">
				<label for="zipCode" class="control-label"><g:message code="client.zipCode.label" default="Zip Code" /></label>
				<div>
					<g:textField class="form-control" name="zipCode" value="${clientInstance?.zipCode}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: clientInstance, field: 'note', 'has-error')} ">
				<label for="note" class="control-label"><g:message code="client.note.label" default="Note" /></label>
				<div>
					<g:textField class="mayus form-control" name="note" value="${clientInstance?.note}"/>
				</div>
			</div>
			
<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	
	});

	function fillName(){
		if($("#name").val().length == 0){
			$("#name").val($("#businessName").val());
		}
	}
	
	
</script>
