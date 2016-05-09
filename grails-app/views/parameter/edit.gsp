<%@ page import="mgmt.config.Parameter" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'parameter.label', default: 'Parameter')}" />
</head>

<body>

	<section id="edit-parameter" class="first">

		<g:hasErrors bean="${parameterInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${parameterInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${parameterInstance?.id}" />
			<g:hiddenField name="version" value="${parameterInstance?.version}" />
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