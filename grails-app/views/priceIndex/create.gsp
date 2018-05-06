<%@ page import="mgmt.index.PriceIndex" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'priceIndex.label', default: 'PriceIndex')}" />
</head>

<body>

	<section id="create-priceIndex" class="first">

		<g:hasErrors bean="${priceIndexInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${priceIndexInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<div class="row">
			<div class="col-md-4">
			<g:render template="form"/>
			</div>
			</div>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				<g:link action="index" class="btn" ><g:message code="default.button.cancel.label" default="Cancelar" /></g:link>
			</div>
		</g:form>

	</section>

</body>

</html>