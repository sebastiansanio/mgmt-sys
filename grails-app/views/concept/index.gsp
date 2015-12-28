
<%@ page import="mgmt.concept.Concept" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'concept.label', default: 'Concept')}" />
</head>

<body>

<section id="index-concept" class="first">
<div class="row">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:textField placeholder="${message(code:'concept.description.label')}" class="form-control" name="description" value="${params.description}" />
</div>
<div class="col-md-2">
<g:textField placeholder="${message(code:'concept.code.label')}" class="form-control" name="code" value="${params.code}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="search" />
</div>
</g:form>
</div>

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="code" title="${message(code: 'concept.code.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="description" title="${message(code: 'concept.description.label')}" />
				<th class="center-aligned"><g:message code="concept.conceptGroup.label" default="Concept Group" /></th>
				<th class="center-aligned"><g:message code="concept.conceptAccount.label" default="Concept Account" /></th>
				<g:sortableColumn class="center-aligned" property="dateCreated" title="${message(code: 'account.dateCreated.label')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${conceptInstanceList}" status="i" var="conceptInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="edit" id="${conceptInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: conceptInstance, field: "code")}</td>
				<td>${fieldValue(bean: conceptInstance, field: "description")}</td>
				<td>${fieldValue(bean: conceptInstance, field: "conceptGroup")}</td>
				<td>${fieldValue(bean: conceptInstance, field: "conceptAccount")}</td>
				<td class="center-aligned"><g:formatDate date="${conceptInstance.dateCreated}"/></td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${conceptInstanceCount}" />
	</div>
</section>

</body>

</html>