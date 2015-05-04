
<%@ page import="mgmt.reports.Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
</head>

<body>

<section id="index-report" class="first">
<div class="col-md-4">
	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="name" title="${message(code: 'report.name.label', default: 'Name')}" />
			
				<th>${message(code:'default.download.label')}</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${reportInstanceList}" status="i" var="reportInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td>${fieldValue(bean: reportInstance, field: "name")}</td>
			
				<td><g:link action="show" id="${reportInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${reportInstanceCount}" />
	</div>
	
</div>
</section>

</body>

</html>