<%@ page import="mgmt.security.SecAuthority" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'secAuthority.label', default: 'SecAuthority')}" />
</head>

<body>

	<section id="edit-secAuthority" class="first">

		<g:hasErrors bean="${secAuthorityInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${secAuthorityInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${secAuthorityInstance?.id}" />
			<g:hiddenField name="version" value="${secAuthorityInstance?.version}" />
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