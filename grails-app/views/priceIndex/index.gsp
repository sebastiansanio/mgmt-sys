
<%@ page import="mgmt.index.PriceIndex" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'priceIndex.label', default: 'PriceIndex')}" />
</head>

<body>

<section id="index-priceIndex" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.edit.label').toUpperCase()}</th>
			
				<g:sortableColumn property="name" params="${params}" title="${message(code: 'priceIndex.name.label').toUpperCase()}" />
			
				<g:sortableColumn property="description" params="${params}" title="${message(code: 'priceIndex.description.label').toUpperCase()}" />
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${priceIndexInstanceList}" status="i" var="priceIndexInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${priceIndexInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
			
				<td>${fieldValue(bean: priceIndexInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: priceIndexInstance, field: "description")}</td>
			
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${priceIndexInstanceCount}" />
	</div>
</section>

</body>

</html>