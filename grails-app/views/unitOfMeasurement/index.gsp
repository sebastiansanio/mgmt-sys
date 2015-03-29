
<%@ page import="mgmt.products.UnitOfMeasurement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'unitOfMeasurement.label', default: 'UnitOfMeasurement')}" />
</head>

<body>

<section id="index-unitOfMeasurement" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="name" title="${message(code: 'unitOfMeasurement.name.label', default: 'Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${unitOfMeasurementInstanceList}" status="i" var="unitOfMeasurementInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${unitOfMeasurementInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: unitOfMeasurementInstance, field: "name")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${unitOfMeasurementInstanceCount}" />
	</div>
</section>

</body>

</html>