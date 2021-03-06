<%@ page import="mgmt.reports.Report" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'report.label')}" />
</head>

<body>


	<section id="edit-report" class="first">

		<g:hasErrors bean="${reportInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${reportInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" action="update" class="form-horizontal" role="form" enctype="multipart/form-data">
			<g:hiddenField name="id" value="${reportInstance?.id}" />
			<g:hiddenField name="version" value="${reportInstance?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			
			<div class="row">
			<div class="col-md-4">
			<g:render template="form"/>
			</div>
			</div>
			<div class="form-actions margin-top-medium">
				<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
	            <g:link action="index" class="btn" ><g:message code="default.button.cancel.label" default="Cancelar" /></g:link>
			</div>
		</g:form>

	</section>

</body>

</html>