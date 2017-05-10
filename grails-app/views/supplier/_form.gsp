<%@ page import="mgmt.persons.Supplier" %>

			<div class="${hasErrors(bean: supplierInstance, field: 'businessName', 'has-error')} ">
				<label for="businessName" class="control-label">${message(code: 'supplier.businessName.label').toUpperCase()}<span class="required-indicator">*</span></label>
				<div>
					<g:textField onchange="fillName();" required="" class="mayus form-control" name="businessName" value="${supplierInstance?.businessName}"/>
				</div>
			</div>
			
			<div class="${hasErrors(bean: supplierInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label">${message(code: 'supplier.name.label').toUpperCase()}<span class="required-indicator">*</span></label>
				<div>
					<g:textField required="" class="mayus form-control" name="name" value="${supplierInstance?.name}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'cuit', 'has-error')} ">
				<label for="cuit" class="control-label"><g:message code="supplier.cuit.label" default="Cuit" /><span class="required-indicator">*</span></label>
				<div>
					<g:textField required="" class="form-control" name="cuit" value="${supplierInstance?.cuit}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'address', 'has-error')} ">
				<label for="address" class="control-label">${message(code: 'supplier.address.label').toUpperCase()}</label>
				<div>
					<g:textField class="mayus form-control" name="address" value="${supplierInstance?.address}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'location', 'has-error')} ">
				<label for="location" class="control-label">${message(code: 'supplier.location.label').toUpperCase()}</label>
				<div>
					<g:textField class="mayus form-control" name="location" value="${supplierInstance?.location}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'province', 'has-error')} ">
				<label for="province" class="control-label">${message(code: 'supplier.province.label').toUpperCase()}</label>
				<div>
					<g:textField class="mayus form-control" name="province" value="${supplierInstance?.province}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'zipCode', 'has-error')} ">
				<label for="zipCode" class="control-label">${message(code: 'supplier.zipCode.label').toUpperCase()}</label>
				<div>
					<g:textField class="form-control" name="zipCode" value="${supplierInstance?.zipCode}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: supplierInstance, field: 'note', 'has-error')} ">
				<label for="note" class="control-label">${message(code: 'supplier.note.label').toUpperCase()}</label>
				<div>
					<g:textField class="mayus form-control" name="note" value="${supplierInstance?.note}"/>
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
