<%@ page import="mgmt.work.Budget" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
</head>

<body>

	<section id="create-budget" class="first">

		<g:hasErrors bean="${budgetInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${budgetInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<div class="row">
			<g:render template="form"/>
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