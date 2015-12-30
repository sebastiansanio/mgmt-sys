
<%@ page import="mgmt.work.Budget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
</head>

<body>

<div class="row margin-top-medium">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:textField placeholder="${message(code:'budget.name.label')}" class="form-control mayus" name="name" value="${params.name}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="search" />
</div>
</g:form>
</div>

<section id="index-budget" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="dateCreated" title="${message(code: 'budget.dateCreated.label', default: 'Date Created')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="code" title="${message(code: 'budget.code.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="name" title="${message(code: 'budget.name.label')}" />
				<th class="center-aligned"><g:message code="budget.client.label" default="Client" /></th>
				<g:sortableColumn class="center-aligned" params="${params}" property="work.code" title="${message(code: 'work.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="directCosts" title="CDO (A-K)" />
				<th class="center-aligned">GGO (L)</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="totalAmount" title="PV" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${budgetInstanceList}" status="i" var="budgetInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="edit" id="${budgetInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td class="center-aligned"><g:formatDate date="${budgetInstance.dateCreated}" /></td>
				<td>${budgetInstance.code}</td>
				<td>${fieldValue(bean: budgetInstance, field: "name")}</td>
				<td>${fieldValue(bean: budgetInstance, field: "client")}</td>
				<td>${mgmt.work.Work.findByBudget(budgetInstance)?.code}
				<g:if test="${!budgetInstance.hasWork}">
					<sec:access url="/budget/generateWork">
						<g:form action="generateWork" id="${budgetInstance.id}">
							<g:submitButton onclick="confirmGenerateWork(event);" class="btn btn-primary btn-xs" name="generateWork" value="${message(code:'work.generateWork.message')}" />
						</g:form>
					</sec:access>
				</g:if>
				
				</td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${budgetInstance.directCosts}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${budgetInstance.generalExpendures}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${budgetInstance.totalAmount}" /></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${budgetInstanceCount}" />
	</div>
</section>


<script>
function confirmGenerateWork(event){
	if(!confirm("${message(code:'work.generateWork.confirm.message')}")){
		event.preventDefault();
	}
}
</script>


</body>

</html>