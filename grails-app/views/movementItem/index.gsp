
<%@ page import="mgmt.movement.MovementItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'movementItem.label', default: 'MovementItem')}" />
</head>

<body>

<div class="row-fluid">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:textField placeholder="${message(code: 'movementItem.description.label')}" class="mayus form-control" name="description" value="${params.description}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="search" />
</div>
</g:form>
</div>

<section id="index-movementItem" class="first">
<hr/>
	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
				<th><g:message code="movementItem.work.label" default="Work" /></th>
				<g:sortableColumn property="description" title="${message(code: 'movementItem.description.label', default: 'Description')}" />
				<g:sortableColumn property="invoiceNumber" title="${message(code: 'movementItem.invoiceNumber.label', default: 'Invoice Number')}" />
				<th><g:message code="movementItem.concept.label" default="Concept" /></th>
				<g:sortableColumn property="date" title="${message(code: 'movementItem.date.label', default: 'Date')}" />
				<th><g:message code="movement.type.label" /></th>
				<th><g:message code="movement.number.label" /></th>
				<th><g:message code="movement.year.label" /></th>
				<g:sortableColumn property="amount" title="${message(code: 'movementItem.amount.label', default: 'Amount')}" />
				<g:sortableColumn property="iva" title="${message(code: 'movementItem.iva.label')}" />
				<g:sortableColumn property="iibb" title="${message(code: 'movementItem.iibb.label')}" />
				<g:sortableColumn property="otherPerceptions" title="${message(code: 'movementItem.otherPerceptions.label')}" />
				<g:sortableColumn property="total" title="${message(code: 'movementItem.total.label')}" />
				<th><g:message code="movementItem.invoiceType.label" /></th>
				<th><g:message code="movementItem.supplier.label" /></th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${movementItemInstanceList}" status="i" var="movementItemInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link controller="${movementItemInstance.movement.type}" action="show" id="${movementItemInstance.movement.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td>${fieldValue(bean: movementItemInstance, field: "work")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "description")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "invoiceNumber")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "concept")}</td>
				<td><g:formatDate date="${movementItemInstance.date}" /></td>
				<td>${message(code:'movement.type.'+movementItemInstance.movement.type)}</td>
				<td>${movementItemInstance.movement.number}</td>
				<td>${movementItemInstance.movement.year}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "amount")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "iibb")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "iva")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "otherPerceptions")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "total")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "invoiceType")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "supplier")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${movementItemInstanceCount}" />
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