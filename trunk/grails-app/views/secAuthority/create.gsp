<%@ page import="mgmt.security.SecAuthority" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'secAuthority.label', default: 'SecAuthority')}" />
</head>

<body>

	<section id="create-secAuthority" class="first">

		<g:hasErrors bean="${secAuthorityInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${secAuthorityInstance}" as="list" />
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
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>

</body>

</html>