<%@ page import="mgmt.movement.Movement" %>

<div class="container-fluid">

<g:hiddenField name="type" value="tr" />

<div class="col-md-3 ${hasErrors(bean: movementInstance, field: 'note', 'has-error')} ">
	<label for="type" class="control-label"><g:message code="movement.note.label" default="Note" /></label>
	<div>
		<g:textArea class="form-control mayus" name="note" value="${movementInstance.note}"/>
	</div>
</div>

</div>

<h4><g:message code="movement.payments.label" /></h4>
<div id="items">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th>${message(code: 'payment.accountFrom.label')}</th>
				<th>${message(code: 'payment.accountTo.label')}</th>
				<th>${message(code: 'payment.amount.label')}</th>
				<th>${message(code: 'payment.paymentDateIn.label')}</th>
				<th>${message(code: 'payment.note.label')}</th>
			</tr>
		</thead>
		<tbody>
			<tr class="form-inline" >
				<td class="td-intableform"><g:select class="select-chosen" name="payments[0].account" from="${mgmt.account.Account.list(sort:'code')}" optionKey="id" required="" value="${movementInstance.payments[0]?.account?.id}"/></td>
				<td class="td-intableform"><g:select class="select-chosen" name="payments[1].account" from="${mgmt.account.Account.list(sort:'code')}" optionKey="id" required="" value="${movementInstance.payments[1]?.account?.id}"/></td>
				<td class="td-intableform"><g:field type="text" class="input-intableform form-control right-aligned" name="payments[0].amount" value="${movementInstance.payments[0]?.amount}" required=""/></td>
				<td class="td-intableform"><bs:datePicker class="input-intableform form-control" name="payments[0].paymentDate" precision="day"  value="${movementInstance.payments[0]?.paymentDate}"  /> </td>
				<td class="td-intableform"><g:textField class="mayus input-intableform form-control" name="payments[0].note" value="${movementInstance.payments[0]?.note}"/></td>
			</tr>
		</tbody>
	</table>
	
</div>
<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	});
	$(function() {
		$('.select-chosen').chosen({search_contains: true});
	});
</script>