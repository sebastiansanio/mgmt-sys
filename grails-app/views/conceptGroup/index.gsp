
<%@ page import="mgmt.concept.ConceptGroup" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'conceptGroup.label', default: 'ConceptGroup')}" />
</head>

<body>

<section id="index-conceptGroup" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" property="name" title="${message(code: 'conceptGroup.name.label', default: 'Name')}" />
				<g:sortableColumn class="center-aligned" property="dateCreated" title="${message(code: 'account.dateCreated.label')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${conceptGroupInstanceList}" status="i" var="conceptGroupInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="edit" id="${conceptGroupInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: conceptGroupInstance, field: "name")}</td>
				<td class="center-aligned"><g:formatDate date="${conceptGroupInstance.dateCreated}"/></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${conceptGroupInstanceCount}" />
	</div>
</section>

</body>

</html>