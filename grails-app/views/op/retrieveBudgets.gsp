<option value="null">Sin presupuesto</option>
<g:each var="budget" in="${budgets}" >
	<g:if test="${budget.realExpendures.remainingAmount > 0 }">
		<option value="${budget.id}">${budget.id} (${g.formatNumber(format: '###,##0.00', number: budget.realExpendures.remainingAmount)})</option>
	</g:if>
</g:each>