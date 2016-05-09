<%@ page import="mgmt.config.Parameter" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'parameter.label', default: 'Parameter')}" />
</head>

<body>

	<section id="create-parameter" class="first">

		<g:hasErrors bean="${parameterInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${parameterInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<g:render template="form"/>
			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
	            <g:link action="index" class="btn" ><g:message code="default.button.cancel.label" /></g:link>
			</div>
		</g:form>

	</section>

</body>

</html>