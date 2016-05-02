<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'accountStatus.label')}" />
</head>

<body>

<section id="index-accountStatus" class="first">
<h4><g:message code="menu.netting.label" /></h4>
<div class="col-md-6">
<table class="table table-bordered">
	<thead>
		<tr>
			<th></th>
			<th>Monto</th>
			<th>IVA</th>
			<th>Total</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Órdenes de ingreso (P800 a P810)</td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.incomeAmount}"/>  </td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.incomeIva}"/></td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.incomeAmount+results.incomeIva}"/></td>
		</tr>
		<tr>
			<td>Órdenes de pago (M800 a M810)</td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.expensesAmount}"/>  </td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.expensesIva}"/></td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.expensesAmount+results.expensesIva}"/>  </td>
		</tr>
		<tr>
			<td>Diferencia</td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.incomeAmount - results.expensesAmount}"/>  </td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.incomeIva - results.expensesIva}"/></td>
			<td class="right-aligned"><g:formatNumber format="###,##0.##" number="${results.incomeAmount+results.incomeIva - (results.expensesAmount+results.expensesIva)}"/></td>
		</tr>
	</tbody>
</table>
</div>

<div class="col-md-1">
<g:form class="noblock" target="_blank" controller="report" action="downloadReport" id="${mgmt.reports.Report.findByCode('netting')?.id}" >
<table class="col-md-6 table table-bordered">
	<tbody>
		<tr>
			<td colspan="2"><g:submitButton class="btn btn-default" name="download" value="${message(code:'default.download.pdf.label')}" /></td>
		</tr>
	</tbody>
</table>
</g:form>


</div>

</section>

</body>

</html>