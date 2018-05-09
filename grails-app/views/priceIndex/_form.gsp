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

<div
	class="${hasErrors(bean: priceIndexInstance, field: 'frequency', 'has-error')} ">
	<label for="frequency" class="control-label">${message(code: 'priceIndex.frequency.label').toUpperCase()}</label>
	<div>
		<g:select class="form-control" name="frequency" valueMessagePrefix="priceIndex.frequency" from="${priceIndexInstance.constraints.frequency.inList }"
			value="${priceIndexInstance?.frequency}" />
	</div>
</div>

<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	});
</script>
