
<%@ page import="mgmt.payment.PaymentOrder" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'paymentOrder.label', default: 'PaymentOrder')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
	<g:set var="noSubMenu" value="${true}" scope="request" />
</head>

<body>

<g:render template="submenu"/>

<section id="index-paymentOrder" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="type" title="${message(code: 'paymentOrder.type.label', default: 'Type')}" />
				
				<g:sortableColumn property="date" title="${message(code: 'paymentOrder.date.label', default: 'Date')}" />
			
				<g:sortableColumn property="number" title="${message(code: 'paymentOrder.number.label', default: 'Number')}" />
			
				
				
			</tr>
		</thead>
		<tbody>
		<g:each in="${paymentOrderInstanceList}" status="i" var="paymentOrderInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${paymentOrderInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: paymentOrderInstance, field: "type")}</td>
				
				<td><g:formatDate date="${paymentOrderInstance.date}" /></td>
			
				<td>${fieldValue(bean: paymentOrderInstance, field: "number")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${paymentOrderInstanceCount}" />
	</div>
</section>

</body>

</html>