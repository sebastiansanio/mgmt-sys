
<%@ page import="mgmt.index.PriceIndexItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'priceIndexItem.label', default: 'PriceIndexItem')}" />
</head>

<body>

<section id="index-priceIndexItem" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.edit.label').toUpperCase()}</th>
				<th>${message(code: 'priceIndexItem.index.label').toUpperCase()}</th>
				<g:sortableColumn property="date" title="${message(code: 'priceIndexItem.date.label').toUpperCase()}" />
				<th>${message(code: 'priceIndexItem.indexValue.label').toUpperCase()}</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${priceIndexItemInstanceList}" status="i" var="priceIndexItemInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${priceIndexItemInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: priceIndexItemInstance, field: "index")}</td>
				<td><g:formatDate date="${priceIndexItemInstance.date}" /></td>
				<td>${fieldValue(bean: priceIndexItemInstance, field: "indexValue")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${priceIndexItemInstanceCount}" />
	</div>
</section>

</body>

</html>