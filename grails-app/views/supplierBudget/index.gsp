
<%@ page import="mgmt.work.SupplierBudget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplierBudget.label', default: 'SupplierBudget')}" />
</head>

<body>


<div class="row margin-top-medium">
<g:form action="index" method="get" >
<div class="col-md-2">Proveedor
<g:select noSelection="${['':'Todos']}" from="${mgmt.persons.Supplier.list([sort:'businessName'])}" optionKey="id" optionValue="nameAndBusinessName"  placeholder="${message(code:'supplierBudget.supplier.label')}" class="form-control select-chosen" name="supplierFilter" value="${params.supplierFilter}" />
</div>
<div class="col-md-2">Rubro
<g:select noSelection="${['':'Todos']}" from="${mgmt.concept.Concept.list([sort:'code'])}" optionKey="id" placeholder="${message(code:'supplierBudget.concept.label')}" class="form-control select-chosen" name="conceptFilter" value="${params.conceptFilter}" />
</div>
<div class="col-md-2">Obra
<g:select noSelection="${['':'Todos']}" from="${mgmt.work.Work.list([sort:'code'])}" optionKey="id" placeholder="${message(code:'supplierBudget.work.label')}" class="form-control select-chosen" name="workFilter" value="${params.workFilter}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.filter.label')}" action="index" />
</div>
</g:form>
</div>


<section id="index-supplierBudget" class="first">

	<table class="table table-condensed-med table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned mayus"><span class="glyphicon glyphicon-pencil"></span></th>
				<g:sortableColumn class="center-aligned mayus" property="id" title="Nº" />
				<th class="center-aligned mayus">OBRA</th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.supplier.label" default="Supplier" /></th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.concept.label" default="Concept" /></th>
				<g:sortableColumn class="center-aligned mayus" property="amount" title="PTO. ORIGINAL" />
				<g:sortableColumn class="center-aligned mayus" property="iva" title="${message(code: 'supplierBudget.iva.label', default: 'Iva')}" />
				<th class="center-aligned mayus">PTO. TOTAL</th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.totalIva.label" /></th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.expendedAmount.label" /></th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.expendedIva.label" /></th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.remainingAmount.label" /></th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.remainingIva.label" /></th>
				<g:sortableColumn class="center-aligned mayus" property="dateCreated" title="${message(code: 'supplierBudget.dateCreated.label')}" />
				<sec:access url="/supplierBudget/delete">
					<th class="center-aligned mayus">${message(code:'default.button.delete.label')}</th>
				</sec:access>			
				<sec:access url="/supplierBudget/close">
					<g:sortableColumn class="center-aligned mayus" property="closed" title="${message(code: 'supplierBudget.close.label')}" />
				</sec:access>
				<th class="center-aligned mayus">TIPO FACT</th>
				<th class="center-aligned mayus"><g:message code="supplierBudget.note.label" /></th>
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
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${supplierBudgetInstance.totalAmount}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${supplierBudgetInstance.totalIva}" /></td>
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
				
					<g:if test="${!supplierBudgetInstance.closed}">
						<sec:access url="/supplierBudget/close">
							<td class="center-aligned">
								<g:form action="close">
									<g:hiddenField name="id" value="${supplierBudgetInstance.id}" />
									<g:hiddenField name="max" value="${params.max}" />
									<g:hiddenField name="sort" value="${params.sort}" />
									<g:hiddenField name="order" value="${params.order}" />
									<g:hiddenField name="offset" value="${params.offset}" />
									<g:submitButton class="btn btn-danger btn-xs" name="close" value="${message(code:'supplierBudget.close.label') }" /> 
								</g:form>
							</td>
						</sec:access>
					</g:if>
					<g:else>
						<sec:access url="/supplierBudget/open">
							<td class="center-aligned">
								<g:form action="open">
									<g:hiddenField name="id" value="${supplierBudgetInstance.id}" />
									<g:hiddenField name="max" value="${params.max}" />
									<g:hiddenField name="sort" value="${params.sort}" />
									<g:hiddenField name="order" value="${params.order}" />
									<g:hiddenField name="offset" value="${params.offset}" />
									<g:submitButton class="btn btn-primary btn-xs" name="open" value="${message(code:'supplierBudget.open.label') }" /> 
								</g:form>
							</td>
						</sec:access>
					</g:else>
				
				<td>${fieldValue(bean: supplierBudgetInstance, field: "invoiceType")}</td>
				<td style="word-wrap: break-word;max-width: 100px;">${fieldValue(bean: supplierBudgetInstance, field: "note")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${supplierBudgetInstanceCount}" params="${params}" />
	</div>
</section>

<script>

$(function() {
	$(".select-chosen").chosen({search_contains: true, width: "200px"});
});
</script>

</body>

</html>