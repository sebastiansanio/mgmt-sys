
<%@ page import="mgmt.persons.Supplier" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
</head>

<body>


<div class="row">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:textField placeholder="${message(code:'supplier.name.label')}" class="form-control" name="name" value="${params.name}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="search" />
</div>
</g:form>
</div>


<section id="index-supplier" class="first">
<hr/>
	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
				<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: 'Name')}" />
				<g:sortableColumn property="businessName" title="${message(code: 'supplier.businessName.label')}" />
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
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${supplierInstanceCount}" params="${params}" />
	</div>
</section>

<script>
	$("form").submit(function( event ) {
		$(".mayus" ).each(function( index ) {
			$(this).val($(this).val().toUpperCase());
		});
	
	});
</script>

</body>

</html>