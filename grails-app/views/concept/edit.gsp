<%@ page import="mgmt.concept.Concept" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'concept.label', default: 'Concept')}" />
</head>

<body>

	<section id="edit-concept" class="first">

		<g:hasErrors bean="${conceptInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${conceptInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${conceptInstance?.id}" />
			<g:hiddenField name="version" value="${conceptInstance?.version}" />
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
		
		<sec:access url="/concept/delete">
			<g:if test="${!conceptInstance.movements  && !mgmt.work.SupplierBudget.countByConcept(conceptInstance)}">
				<g:form action="delete">
					<g:hiddenField name="_method" value="DELETE" />
					<g:hiddenField name="id" value="${conceptInstance.id}" />
					<g:submitButton onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger" name="delete" value="${message(code:'default.button.delete.label') }" /> 
				</g:form>
			</g:if>
		</sec:access>
	</section>

</body>

</html>