<%@ page import="mgmt.core.Work" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
	<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>

<body>

	<section id="edit-work" class="first">

		<g:hasErrors bean="${workInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${workInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${workInstance?.id}" />
			<g:hiddenField name="version" value="${workInstance?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			
			<g:render template="form"/>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>

</body>

</html>