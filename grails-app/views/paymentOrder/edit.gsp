<%@ page import="mgmt.payment.PaymentOrder" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'paymentOrder.label', default: 'PaymentOrder')}" />
	<title><g:message code="default.edit.label" args="[entityName]" /></title>
	<g:set var="noSubMenu" value="${true}" scope="request" />
</head>

<body>

<g:render template="submenu"/>

	<section id="edit-paymentOrder" class="first">

		<g:hasErrors bean="${paymentOrderInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${paymentOrderInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" class="form-horizontal" role="form" >
			<g:hiddenField name="id" value="${paymentOrderInstance?.id}" />
			<g:hiddenField name="version" value="${paymentOrderInstance?.version}" />
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