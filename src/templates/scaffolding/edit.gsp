<%=packageName%>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
</head>

<body>

	<section id="edit-${domainClass.propertyName}" class="first">

		<g:hasErrors bean="\${${propertyName}}">
		<div class="alert alert-danger">
			<g:renderErrors bean="\${${propertyName}}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
			<g:hiddenField name="id" value="\${${propertyName}?.id}" />
			<g:hiddenField name="version" value="\${${propertyName}?.version}" />
			<g:hiddenField name="_method" value="PUT" />
			<div class="row">
			<g:render template="form"/>
			</div>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:actionSubmit class="btn btn-primary" action="update" value="\${message(code: 'default.button.update.label', default: 'Update')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>

</body>

</html>