<%@ page import="mgmt.persons.Supplier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
</head>

<body>

	<section id="edit-supplier" class="first">

		<g:hasErrors bean="${supplierInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${supplierInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${supplierInstance?.id}" />
			<g:hiddenField name="version" value="${supplierInstance?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			<div class="row">
			<g:render template="form"/>
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