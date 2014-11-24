<%@ page import="mgmt.payment.PaymentOrder" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'paymentOrder.label', default: 'PaymentOrder')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
	<g:set var="noSubMenu" value="${true}" scope="request" />
</head>

<body>

<g:render template="submenu"/>

	<section id="create-paymentOrder" class="first">

		<g:hasErrors bean="${paymentOrderInstance}">
		<div class="alert alert-danger">
			<g:renderErrors bean="${paymentOrderInstance}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" class="form-horizontal" role="form" >
			<g:render template="form"/>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
	            <button class="btn" type="reset"><g:message code="default.button.reset.label" default="Reset" /></button>
			</div>
		</g:form>

	</section>

</body>

</html>