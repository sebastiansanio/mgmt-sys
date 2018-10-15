
<%@ page import="mgmt.concept.ConceptGroup" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>

<section id="index-conceptGroup" class="first">

		<g:form action="save" class="form-horizontal" role="form" >
			<div class="row">
			<div class="col-md-4">
			<g:render template="form"/>
				
				<div class="${hasErrors(bean: conceptGroupInstance, field: 'name', 'has-error')} ">
					<label for="name" class="control-label"><g:message code="conceptGroup.name.label" default="Name" /></label>
					<div>
						<g:textField class="mayus form-control" name="name" value="${conceptGroupInstance?.name}"/>
					</div>
				</div>
			
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