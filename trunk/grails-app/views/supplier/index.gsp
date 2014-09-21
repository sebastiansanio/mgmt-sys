
<%@ page import="mgmt.persons.Supplier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
	<title><g:message code="default.index.label" args="[entityName]" /></title>
</head>

<body>

<section id="index-supplier" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
			
				<g:sortableColumn property="cuit" title="${message(code: 'supplier.cuit.label', default: 'Cuit')}" />
			
				<g:sortableColumn property="dateCreated" title="${message(code: 'default.dateCreated.label', default: 'Date Created')}" />
			
				<g:sortableColumn property="lastUpdated" title="${message(code: 'default.lastUpdated.label', default: 'Last Updated')}" />
			
				<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: 'Name')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			
				<td><g:link action="show" id="${supplierInstance.id}">${fieldValue(bean: supplierInstance, field: "cuit")}</g:link></td>
			
				<td><g:formatDate date="${supplierInstance.dateCreated}" /></td>
			
				<td><g:formatDate date="${supplierInstance.lastUpdated}" /></td>
			
				<td>${fieldValue(bean: supplierInstance, field: "name")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${supplierInstanceCount}" />
	</div>
</section>

</body>

</html>