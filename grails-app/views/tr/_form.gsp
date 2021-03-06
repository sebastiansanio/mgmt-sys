<%@ page import="mgmt.movement.Movement" %>

<div class="container-fluid">

<g:hiddenField name="type" value="tr" />

<div class="col-md-3 ${hasErrors(bean: movementInstance, field: 'note', 'has-error')} ">
	<label for="type" class="control-label"><g:message code="movement.note.label" default="Note" /></label>
	<div>
		<g:textArea class="form-control mayus" name="note" value="${movementInstance.note}"/>
	</div>
</div>

<g:if test="${movementInstance.number}">
<div class="col-md-2" >
	<label for="toString" class="control-label"><g:message code="movement.label" /></label>
	<div>
		<g:field type="text" disabled="true" class="form-control mayus importantBig" name="toString" value="${movementInstance.toString()}"/>
	</div>
</div>
</g:if>

<div class="col-md-1" >
	<label for="dateCreated" class="control-label"><g:message code="movement.dateCreated.label" /></label>
	<div>
		<g:field type="text" disabled="true" class="form-control mayus importantBig" name="dateCreated" value="${(movementInstance.dateCreated?:new Date()).format("dd/MM/yyyy")}"/>
	</div>
</div>

</div>

<h4><g:message code="movement.payments.label" /></h4>
<div id="items">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.accountFrom.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.paymentDateCredit.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.accountTo.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.paymentDateDebit.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.amount.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.checkNumber.label')}</th>
				<th class="center-aligned vertical-center-aligned">${message(code: 'payment.note.label')}</th>
			</tr>
		</thead>
		<tbody>
			<tr class="form-inline" >
				<td class="td-intableform"><g:select class="select-chosen" name="payments[0].account" from="${mgmt.account.Account.list(sort:'code')}" optionKey="id" required="" value="${movementInstance.payments[0]?.account?.id}"/></td>
				<td class="td-intableform"><bs:datePicker class="center-aligned input-intableform form-control" id="paymentDate-1" name="payments[1].paymentDate" precision="day"  value="${movementInstance.payments[1]?.paymentDate}"  /> </td>
				<td class="td-intableform"><g:select class="select-chosen" name="payments[1].account" from="${mgmt.account.Account.list(sort:'code')}" optionKey="id" required="" value="${movementInstance.payments[1]?.account?.id}"/></td>
				<td class="td-intableform"><bs:datePicker class="center-aligned input-intableform form-control" id="paymentDate-0" name="payments[0].paymentDate" precision="day"  value="${movementInstance.payments[0]?.paymentDate}"  /> </td>
				<td class="td-intableform"><g:field type="text" class="autonumeric input-intableform form-control right-aligned" name="payments[0].amount" value="${movementInstance.payments[0]?.amount}" required=""/></td>
				<td class="td-intableform"><g:textField class="mayus input-intableform form-control" name="payments[0].checkNumber" value="${movementInstance.payments[0]?.checkNumber}"/></td>
				<td class="td-intableform"><g:textField class="mayus input-intableform form-control" name="payments[0].note" value="${movementInstance.payments[0]?.note}"/></td>
			</tr>
		</tbody>
	</table>
</div>
	
<g:hiddenField name="max" value="${params.max}" />
<g:hiddenField name="sort" value="${params.sort}" />
<g:hiddenField name="order" value="${params.order}" />
<g:hiddenField name="offset" value="${params.offset}" />
<g:hiddenField name="checkedFilter" value="${params.checkedFilter}" />
<g:hiddenField name="numberFilter" value="${params.numberFilter}" />
<g:hiddenField name="yearFilter" value="${params.yearFilter}" />
	
	
<script>
	$(function() {
		$('.select-chosen').chosen({search_contains: true});
		$('#items .autonumeric').autoNumeric('init',autoNumericOptions);
		
		$('input[type="submit"]').click(function( event ) {
			$(".mayus" ).each(function( index ) {
				$(this).val($(this).val().toUpperCase());
			});

			var paymentDateFromMillis = ${mgmt.config.Parameter.findByCode("FECHA_PAGO_DESDE").asDate().getTime()};
			var paymentDateToMillis = ${mgmt.config.Parameter.findByCode("FECHA_PAGO_HASTA").asDate().getTime()};
				
			var paymentDateMillis = $('#paymentDate-0').datepicker('getDate').getTime();  
			if(paymentDateMillis > paymentDateToMillis || paymentDateMillis < paymentDateFromMillis){
				alert('${message(code:'payment.dateOutOfRange.save.message')}');
				event.preventDefault();
				return;
			}

			paymentDateMillis = $('#paymentDate-1').datepicker('getDate').getTime();  
			if(paymentDateMillis > paymentDateToMillis || paymentDateMillis < paymentDateFromMillis){
				alert('${message(code:'payment.dateOutOfRange.save.message')}');
				event.preventDefault();
				return;
			}

			$(".autonumeric" ).each(function( index ) {
				$(this).val($(this).val().replace(/\./g, '').replace(/,/g,'.'));
			});

			
		});

	});
</script>

<g:if test="${movementInstance.checked}">
	<script>
		$(function() {
			$(".form-horizontal :input").prop('disabled', true);
			$(".form-horizontal :submit").hide();
		});
	</script>
</g:if>