
<%@ page import="mgmt.movement.MovementItem" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'movementItem.label', default: 'MovementItem')}" />
</head>

<body>

<br/>
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
	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.show.label')}</th>
				<th class="center-aligned"><g:message code="movementItem.work.label" default="Work" /></th>
				<g:sortableColumn params="${params}" class="center-aligned" property="description" title="${message(code: 'movementItem.description.label', default: 'Description')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="invoiceNumber" title="${message(code: 'movementItem.invoiceNumber.label', default: 'Invoice Number')}" />
				<th class="center-aligned"><g:message code="movementItem.concept.label" default="Concept" /></th>
				<g:sortableColumn params="${params}" class="center-aligned" property="date" title="${message(code: 'movementItem.date.label', default: 'Date')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="movement.type" title="${message(code: 'movement.type.label')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="movement.number" title="${message(code: 'movement.number.label')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="movement.year" title="${message(code: 'movement.year.label')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="amount" title="${message(code: 'movementItem.amount.label', default: 'Amount')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="iva" title="${message(code: 'movementItem.iva.label')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="iibb" title="${message(code: 'movementItem.iibb.label')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="otherPerceptions" title="${message(code: 'movementItem.otherPerceptions.label')}" />
				<g:sortableColumn params="${params}" class="center-aligned" property="total" title="${message(code: 'movementItem.total.label')}" />
				<th class="center-aligned"><g:message code="movementItem.invoiceType.label" /></th>
				<th class="center-aligned"><g:message code="movementItem.supplier.label" /></th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${movementItemInstanceList}" status="i" var="movementItemInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link controller="${movementItemInstance.movement.type}" action="show" id="${movementItemInstance.movement.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td>${fieldValue(bean: movementItemInstance, field: "work")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "description")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "invoiceNumber")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "concept")}</td>
				<td><g:formatDate date="${movementItemInstance.date}" /></td>
				<td>${message(code:'movement.type.'+movementItemInstance.movement.type)}</td>
				<td>${movementItemInstance.movement.number}</td>
				<td>${movementItemInstance.movement.year}</td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${movementItemInstance.amount}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${movementItemInstance.iibb}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${movementItemInstance.iva}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${movementItemInstance.otherPerceptions}" /></td>
				<td class="right-aligned"><g:formatNumber format="###,##0.00" number="${movementItemInstance.total}" /></td>
				<td>${fieldValue(bean: movementItemInstance, field: "invoiceType")}</td>
				<td>${fieldValue(bean: movementItemInstance, field: "supplier")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${movementItemInstanceCount}" params="${params}" />
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