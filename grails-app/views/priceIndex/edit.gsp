<%@ page import="mgmt.index.PriceIndex" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'priceIndex.label', default: 'PriceIndex')}" />
</head>

<body>

	<section id="edit-priceIndex" class="first">

		<g:hasErrors bean="${priceIndexInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${priceIndexInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${priceIndexInstance?.id}" />
			<g:hiddenField name="version" value="${priceIndexInstance?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			<div class="row">
			<div class="col-md-4">
			<g:render template="form"/>
			</div>
			</div>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
	        	<g:link action="index" class="btn" ><g:message code="default.button.cancel.label" default="Cancelar" /></g:link>
			</div>
		</g:form>

	</section>

</body>

</html>