<%@ page import="mgmt.index.PriceIndexItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'priceIndexItem.label', default: 'PriceIndexItem')}" />
</head>

<body>

	<section id="edit-priceIndexItem" class="first">

		<g:hasErrors bean="${priceIndexItemInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${priceIndexItemInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${priceIndexItemInstance?.id}" />
			<g:hiddenField name="version" value="${priceIndexItemInstance?.version}" />
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