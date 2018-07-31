
<%@ page import="mgmt.index.PriceIndexItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'priceIndexItem.label', default: 'PriceIndexItem')}" />
</head>

<body>


<div class="row margin-top-medium">
	<g:form action="index" method="get" >
		<div class="col-md-2">
			<g:select noSelection="${['':'Todos']}" class="form-control" id="indexId" name="indexId" from="${mgmt.index.PriceIndex.list()}" optionKey="id" value="${params.long('indexId')}"/>
		</div>
		<div class="col-md-4">
			<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="index" />
		</div>
		<div class="col-md-1">
			<g:link action="checkMissingValues" class="btn btn-default" >Verificar valores faltantes </g:link>
		</div>
	</g:form>
</div>


<section id="index-priceIndexItem" class="first col-md-8">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.edit.label').toUpperCase()}</th>
				<th>${message(code: 'priceIndexItem.index.label').toUpperCase()}</th>
				<th>${message(code: 'priceIndexItem.month.label').toUpperCase()}</th>
				<g:sortableColumn params="${params}" property="date" title="${message(code: 'priceIndexItem.day.label').toUpperCase()}" />
				<th>${message(code: 'priceIndexItem.indexValue.label').toUpperCase()}</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${priceIndexItemInstanceList}" status="i" var="priceIndexItemInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${priceIndexItemInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: priceIndexItemInstance, field: "index")}</td>
				<td>${message(code:'month.'+(priceIndexItemInstance.date[Calendar.MONTH]+1)+'.label')+" " + (priceIndexItemInstance.date[Calendar.YEAR]%100)}</td>
				<td><g:formatDate date="${priceIndexItemInstance.date}" /></td>
				<td><span class="pull-right"><g:formatNumber number="${fieldValue(bean: priceIndexItemInstance, field: "indexValue")}" format="#.00"/></span></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate params="${params}" total="${priceIndexItemInstanceCount}" />
	</div>
</section>

</body>

</html>