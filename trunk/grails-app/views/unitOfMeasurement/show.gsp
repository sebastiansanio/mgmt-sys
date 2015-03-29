
<%@ page import="mgmt.products.UnitOfMeasurement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'unitOfMeasurement.label', default: 'UnitOfMeasurement')}" />
</head>

<body>

<section id="show-unitOfMeasurement" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="unitOfMeasurement.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: unitOfMeasurementInstance, field: "name")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="unitOfMeasurement.dateCreated.label" default="Date Created" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${unitOfMeasurementInstance?.dateCreated}" /></td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="unitOfMeasurement.lastUpdated.label" default="Last Updated" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${unitOfMeasurementInstance?.lastUpdated}" /></td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>