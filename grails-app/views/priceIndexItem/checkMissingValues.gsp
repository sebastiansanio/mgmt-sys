
<%@ page import="mgmt.index.PriceIndexItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>


<section class="first col-md-4">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code: 'priceIndexItem.index.label').toUpperCase()}</th>
				<th>${message(code: 'priceIndexItem.month.label').toUpperCase()}</th>
				<th>${message(code: 'priceIndexItem.day.label').toUpperCase()}</th>
				<th>${message(code: 'default.create.label').toUpperCase()}</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${missingValues}" status="i" var="missingValue">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td>${missingValue.priceIndex}</td>
				<td>${message(code:'month.'+(missingValue.dateValue[Calendar.MONTH]+1)+'.label')+" " + (missingValue.dateValue[Calendar.YEAR]%100)}</td>
				<td><g:formatDate date="${missingValue.dateValue}" /></td>
				<td><g:link action="create" params="${[date: g.formatDate(date:missingValue.dateValue), "index.id": missingValue.priceIndexId]}" ><span class="glyphicon glyphicon-pencil"></span></g:link></td>
			</tr>
		</g:each>
		</tbody>
	</table>
</section>

</body>

</html>