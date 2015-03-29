<%@ page import="mgmt.movement.Movement" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'movement.label', default: 'Movement')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>

<body>


	<section id="create-movement" class="first">

		<g:hasErrors bean="${movementInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${movementInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<g:render template="form"/>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
	            <g:link action="index" class="btn" ><g:message code="default.button.cancel.label" default="Cancelar" /></g:link>
			</div>
		</g:form>

	</section>

</body>

</html>