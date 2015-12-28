
<%@ page import="mgmt.invoice.InvoiceType" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'invoiceType.label', default: 'InvoiceType')}" />
</head>

<body>

<section id="index-invoiceType" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.edit.label')}</th>
				<g:sortableColumn property="code" title="${message(code: 'invoiceType.code.label', default: 'Code')}" />
				<g:sortableColumn class="center-aligned" property="dateCreated" title="${message(code: 'account.dateCreated.label')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${invoiceTypeInstanceList}" status="i" var="invoiceTypeInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${invoiceTypeInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: invoiceTypeInstance, field: "code")}</td>
				<td class="center-aligned"><g:formatDate date="${invoiceTypeInstance.dateCreated}"/></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${invoiceTypeInstanceCount}" />
	</div>
</section>

</body>

</html>