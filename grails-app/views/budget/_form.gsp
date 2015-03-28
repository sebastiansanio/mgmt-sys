<%@ page import="mgmt.work.Budget" %>



			<div class="${hasErrors(bean: budgetInstance, field: 'client', 'has-error')} ">
				<label for="client" class="control-label"><g:message code="budget.client.label" default="Client" /></label>
				<div>
					<g:select class="form-control" id="client" name="client.id" from="${mgmt.persons.Client.list()}" optionKey="id" value="${budgetInstance?.client?.id}" noSelection="['null': '']"/>
				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'dateCrated', 'has-error')} required">
				<label for="dateCrated" class="control-label"><g:message code="budget.dateCrated.label" default="Date Crated" /><span class="required-indicator">*</span></label>
				<div>
					<bs:datePicker class="form-control" name="dateCrated" precision="day"  value="${budgetInstance?.dateCrated}"  />
				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'directCosts', 'has-error')} required">
				<label for="directCosts" class="control-label"><g:message code="budget.directCosts.label" default="Direct Costs" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="directCosts" value="${fieldValue(bean: budgetInstance, field: 'directCosts')}" required=""/>
				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'iibbPercentage', 'has-error')} required">
				<label for="iibbPercentage" class="control-label"><g:message code="budget.iibbPercentage.label" default="Iibb Percentage" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="iibbPercentage" value="${fieldValue(bean: budgetInstance, field: 'iibbPercentage')}" required=""/>
				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'indirectOverheadPercentage', 'has-error')} required">
				<label for="indirectOverheadPercentage" class="control-label"><g:message code="budget.indirectOverheadPercentage.label" default="Indirect Overhead Percentage" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="indirectOverheadPercentage" value="${fieldValue(bean: budgetInstance, field: 'indirectOverheadPercentage')}" required=""/>
				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'items', 'has-error')} ">
				<label for="items" class="control-label"><g:message code="budget.items.label" default="Items" /></label>
				<div>
					
<ul class="one-to-many">
<g:each in="${budgetInstance?.items?}" var="i">
    <li><g:link controller="budgetItem" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="budgetItem" action="create" params="['budget.id': budgetInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'budgetItem.label', default: 'BudgetItem')])}</g:link>
</li>
</ul>

				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'ivaPercentage', 'has-error')} required">
				<label for="ivaPercentage" class="control-label"><g:message code="budget.ivaPercentage.label" default="Iva Percentage" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="ivaPercentage" value="${fieldValue(bean: budgetInstance, field: 'ivaPercentage')}" required=""/>
				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'name', 'has-error')} ">
				<label for="name" class="control-label"><g:message code="budget.name.label" default="Name" /></label>
				<div>
					<g:textField class="form-control" name="name" value="${budgetInstance?.name}"/>
				</div>
			</div>

			<div class="${hasErrors(bean: budgetInstance, field: 'profitPercentage', 'has-error')} required">
				<label for="profitPercentage" class="control-label"><g:message code="budget.profitPercentage.label" default="Profit Percentage" /><span class="required-indicator">*</span></label>
				<div>
					<g:field class="form-control" name="profitPercentage" value="${fieldValue(bean: budgetInstance, field: 'profitPercentage')}" required=""/>
				</div>
			</div>
