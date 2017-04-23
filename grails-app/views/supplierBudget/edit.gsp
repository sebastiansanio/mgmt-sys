<%@ page import="mgmt.work.SupplierBudget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplierBudget.label', default: 'SupplierBudget')}" />
</head>

<body>

	<section id="edit-supplierBudget" class="first">
		<g:hasErrors bean="${supplierBudgetInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${supplierBudgetInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${supplierBudgetInstance?.id}" />
			<g:hiddenField name="version" value="${supplierBudgetInstance?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			<g:render template="form"/>
			<div class="form-actions margin-top-medium">
				<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				<g:link action="index" class="btn" ><g:message code="default.button.cancel.label" default="Cancelar" /></g:link>
			</div>
		</g:form>

	</section>

</body>

</html>