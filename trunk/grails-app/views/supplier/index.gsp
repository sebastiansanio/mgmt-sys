
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
			
				<g:sortableColumn property="dateCreated" title="${message(code: 'supplier.dateCreated.label', default: 'Date Created')}" />
			
				<g:sortableColumn property="lastUpdated" title="${message(code: 'supplier.lastUpdated.label', default: 'Last Updated')}" />
			
				<g:sortableColumn property="location" title="${message(code: 'supplier.location.label', default: 'Location')}" />
			
				<g:sortableColumn property="note" title="${message(code: 'supplier.note.label', default: 'Note')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${supplierInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: supplierInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "address")}</td>
			
				<td><g:formatDate date="${supplierInstance.dateCreated}" /></td>
			
				<td><g:formatDate date="${supplierInstance.lastUpdated}" /></td>
			
				<td>${fieldValue(bean: supplierInstance, field: "location")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "note")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "province")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "zipCode")}</td>
			
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