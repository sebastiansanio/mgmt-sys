
<%@ page import="mgmt.persons.Supplier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
</head>

<body>

<div>
<g:form action="search" method="get" >
<g:textField name="name" value="${params.name}" />

<g:actionSubmit value="search"/>
</g:form>
</div>

<section id="index-supplier" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: 'Name')}" />
			
				<g:sortableColumn property="businessName" title="${message(code: 'supplier.businessName.label', default: 'Business Name')}" />
			
				<g:sortableColumn property="cuit" title="${message(code: 'supplier.cuit.label', default: 'Cuit')}" />
			
				<g:sortableColumn property="address" title="${message(code: 'supplier.address.label', default: 'Address')}" />
			
				<g:sortableColumn property="location" title="${message(code: 'supplier.location.label', default: 'Location')}" />
			
				<g:sortableColumn property="province" title="${message(code: 'supplier.province.label', default: 'Province')}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${supplierInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: supplierInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "businessName")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "cuit")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "address")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "location")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "province")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "zipCode")}</td>
			
				<td>${fieldValue(bean: supplierInstance, field: "note")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${supplierInstanceCount}" params="${params}" />
	</div>
</section>

</body>

</html>