
<%@ page import="mgmt.work.SupplierBudget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplierBudget.label', default: 'SupplierBudget')}" />
</head>

<body>

<section id="index-supplierBudget" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<th class="center-aligned">${message(code:'supplierBudget.id.label')}</th>
				<th class="center-aligned"><g:message code="supplierBudget.work.label" default="Work" /></th>
				<th class="center-aligned"><g:message code="supplierBudget.supplier.label" default="Supplier" /></th>
				<th class="center-aligned"><g:message code="supplierBudget.concept.label" default="Concept" /></th>
				<g:sortableColumn class="center-aligned" property="amount" title="${message(code: 'supplierBudget.amount.label', default: 'Amount')}" />
				<g:sortableColumn class="center-aligned" property="iva" title="${message(code: 'supplierBudget.iva.label', default: 'Iva')}" />
				<th class="center-aligned"><g:message code="supplierBudget.expendedAmount.label" /></th>
				<th class="center-aligned"><g:message code="supplierBudget.expendedIva.label" /></th>
				<th class="center-aligned"><g:message code="supplierBudget.remainingAmount.label" /></th>
				<th class="center-aligned"><g:message code="supplierBudget.remainingIva.label" /></th>
				<g:sortableColumn class="center-aligned" property="dateCreated" title="${message(code: 'supplierBudget.dateCreated.label')}" />
				<sec:access url="/supplierBudget/delete">
					<th class="center-aligned">${message(code:'default.button.delete.label')}</th>
				</sec:access>			
				<th class="center-aligned"><g:message code="supplierBudget.note.label" /></th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${supplierBudgetInstanceList}" status="i" var="supplierBudgetInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="edit" id="${supplierBudgetInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${supplierBudgetInstance.id}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "work")}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "supplier")}</td>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "concept")}</td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${supplierBudgetInstance.amount}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${supplierBudgetInstance.iva}" /></td>
				<g:set var="realExpendures" value="${supplierBudgetInstance.realExpendures }" />
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${realExpendures.expendedAmount}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${realExpendures.expendedIva}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${realExpendures.remainingAmount}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${realExpendures.remainingIva}" /></td>
				<td class="center-aligned"><g:formatDate date="${supplierBudgetInstance.dateCreated}"/></td>
				<sec:access url="/supplierBudget/delete">
					<td class="center-aligned">
						<g:form action="delete">
							<g:hiddenField name="_method" value="DELETE" />
							<g:hiddenField name="id" value="${supplierBudgetInstance.id}" />
							<button onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger btn-xs" name="delete"><span class="glyphicon glyphicon-trash"></span> </button>
						</g:form>
					</td>
				</sec:access>
				<td>${fieldValue(bean: supplierBudgetInstance, field: "note")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${supplierBudgetInstanceCount}" />
	</div>
</section>

</body>

</html>