<%@ page import="mgmt.index.PriceIndexItem"%>

<div
	class="${hasErrors(bean: priceIndexItemInstance, field: 'index', 'has-error')} required">
	<label for="index" class="control-label">
		${message(code: 'priceIndexItem.index.label').toUpperCase()} <span
		class="required-indicator">*</span>
	</label>
	<div>
		<g:select class="form-control" id="index" name="index.id"
			from="${mgmt.index.PriceIndex.list()}" optionKey="id" required=""
			value="${priceIndexItemInstance?.index?.id}" />
	</div>
</div>


<div
	class="${hasErrors(bean: priceIndexItemInstance, field: 'date', 'has-error')} required">
	<label for="date" class="control-label"> ${message(code: 'priceIndexItem.date.label').toUpperCase()}
		<span class="required-indicator">*</span></label>
	<div>
		<bs:datePicker class="form-control" name="date" precision="day"
			value="${priceIndexItemInstance?.date}" />
	</div>
</div>




<div
	class="${hasErrors(bean: priceIndexItemInstance, field: 'indexValue', 'has-error')} required">
	<label for="indexValue" class="control-label">
		${message(code: 'priceIndexItem.indexValue.label').toUpperCase()} <span
		class="required-indicator">*</span>
	</label>
	<div>

	<g:field type="text" class="form-control" name="indexValue"	value="${priceIndexItemInstance.indexValue }" required="" />

	</div>
</div>

