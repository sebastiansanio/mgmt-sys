
<%@ page import="mgmt.reports.Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
</head>

<body>

<section id="show-report" class="first">

	<div class="col-md-4">
	<h3>${reportInstance.name} </h3>
	<g:form target="_blank" class="noblock" action="downloadReport" method="GET">
		<g:hiddenField name="id" value="${reportInstance.id }"/>
		
		<table class="table">
		<g:each var="variable" in="${reportInstance.variablesAsList()}">
		<tr>
		
		<td>${variable.variable}</td>
		<td>
			<g:if test="${variable.type=="number"}">
				<g:field class="form-control" name="${variable.jasperVariable}" type="number"/>
			</g:if> 
			<g:if test="${variable.type=="date"}">
				<bs:datePicker class="form-control" name="${variable.jasperVariable}" precision="day"/>
			</g:if> 
		
		</td>
		</tr>
		</g:each>
		</table>
		<g:submitButton class="btn btn-default" name="${message(code:'default.download.label')}"/>
			
	</g:form>
	</div>
</section>

</body>

</html>