
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
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: 'Name')}" />
			
				<g:sortableColumn property="address" title="${message(code: 'supplier.address.label', default: 'Address')}" />
		
				<g:sortableColumn property="cuit" title="${message(code: 'supplier.cuit.label', default: 'Cuit')}" />
			
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${supplierInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: supplierInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "address")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "cuit")}</td>
			
			
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