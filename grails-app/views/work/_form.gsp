<%@ page import="mgmt.work.Work" %>

			<div class="${hasErrors(bean: workInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="work.name.label" default="Name" /></label>
				<div>
					<g:textField required="" class="mayus form-control" name="name" value="${workInstance?.name}"/>
				</div>
			</div>
			
			<div class="${hasErrors(bean: workInstance, field: 'type', 'has-error')} ">
				<label for="type" class="control-label"><g:message code="work.type.label" default="Type" /></label>
				<div>
					<g:select required="" class="form-control" name="type" from="${workInstance.constraints.type.inList}" value="${workInstance?.type}" valueMessagePrefix="work.type" noSelection="['': '']"/>
				</div>
			</div>
			
			<div class="${hasErrors(bean: workInstance, field: 'finished', 'has-error')} ">
				<label for="finished" class="control-label"><g:message code="work.finished.label" default="Finished" /></label>
				<div>
					<g:checkBox name="finished" value="${workInstance?.finished}" />
				</div>
			</div>
			
			<div class="${hasErrors(bean: workInstance, field: 'client', 'has-error')} ">
				<label for="client" class="control-label"><g:message code="work.client.label" default="Client" /></label>
				<div>
					<g:select class="form-control" id="client" name="client.id" from="${mgmt.persons.Client.list()}" optionKey="id" value="${workInstance?.client?.id}" noSelection="['null': '']"/>
				</div>
			</div>


			<div class="${hasErrors(bean: workInstance, field: 'budget', 'has-error')} ">
				<label for="budget" class="control-label"><g:message code="work.budget.label" default="Budget" /></label>
				<div>
					<g:select class="form-control" id="budget" name="budget.id" from="${mgmt.work.Budget.list()}" optionKey="id" value="${workInstance?.budget?.id}" noSelection="['null': '']"/>
				</div>
			</div>
			
<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	
	});
</script>




