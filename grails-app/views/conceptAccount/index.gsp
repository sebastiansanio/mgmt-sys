
<%@ page import="mgmt.concept.ConceptAccount" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'conceptAccount.label', default: 'ConceptAccount')}" />
</head>

<body>

<section id="index-conceptAccount" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.show.label')}</th>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" property="name" title="${message(code: 'conceptAccount.name.label', default: 'Name')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${conceptAccountInstanceList}" status="i" var="conceptAccountInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="show" id="${conceptAccountInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td class="center-aligned"><g:link action="edit" id="${conceptAccountInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td class="center-aligned">${fieldValue(bean: conceptAccountInstance, field: "name")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${conceptAccountInstanceCount}" />
	</div>
</section>

</body>

</html>