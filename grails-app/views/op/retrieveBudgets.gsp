<g:if test="${!budgets}">
	<option value="null">Sin presupuesto</option>
</g:if>
<g:each var="budget" in="${budgets}" >
	<option value="${budget.id}">${budget.id} (${g.formatNumber(format: '###,##0.00', number: budget.realExpendures.remainingAmount)})</option>
</g:each>