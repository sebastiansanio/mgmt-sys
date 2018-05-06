<%@ page import="mgmt.index.PriceIndex"%>



<div
	class="${hasErrors(bean: priceIndexInstance, field: 'name', 'has-error')} ">
	<label for="name" class="control-label">${message(code: 'priceIndex.name.label').toUpperCase()}</label>
	<div>
		<g:textField class="form-control mayus" name="name"
			value="${priceIndexInstance?.name}" />
	</div>
</div>

<div
	class="${hasErrors(bean: priceIndexInstance, field: 'description', 'has-error')} ">
	<label for="description" class="control-label">${message(code: 'priceIndex.description.label').toUpperCase()}</label>
	<div>
		<g:textField class="form-control mayus" name="description"
			value="${priceIndexInstance?.description}" />
	</div>
</div>

<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	});
</script>
