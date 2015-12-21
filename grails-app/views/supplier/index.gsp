
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
				<th class="center-aligned">${message(code:'default.show.label')}</th>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="name" title="${message(code: 'supplier.name.label', default: 'Name')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="businessName" title="${message(code: 'supplier.businessName.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="cuit" title="${message(code: 'supplier.cuit.label', default: 'Cuit')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="address" title="${message(code: 'supplier.address.label', default: 'Address')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="location" title="${message(code: 'supplier.location.label', default: 'Location')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="province" title="${message(code: 'supplier.province.label', default: 'Province')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="show" id="${supplierInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td class="center-aligned"><g:link action="edit" id="${supplierInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
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