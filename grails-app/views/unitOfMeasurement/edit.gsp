<%@ page import="mgmt.products.UnitOfMeasurement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'unitOfMeasurement.label', default: 'UnitOfMeasurement')}" />
</head>

<body>

	<section id="edit-unitOfMeasurement" class="first">

		<g:hasErrors bean="${unitOfMeasurementInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${unitOfMeasurementInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${unitOfMeasurementInstance?.id}" />
			<g:hiddenField name="version" value="${unitOfMeasurementInstance?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			<div class="row">
			<div class="col-md-4">
			<g:render template="form"/>
			</div>
			</div>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>

</body>

</html>