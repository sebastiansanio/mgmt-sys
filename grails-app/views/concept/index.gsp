
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
				<th>${message(code:'default.show.label')}</th>
			
				<g:sortableColumn property="code" title="${message(code: 'concept.code.label', default: 'Code')}" />
				<g:sortableColumn property="description" title="${message(code: 'concept.description.label', default: 'Description')}" />
				<th><g:message code="concept.conceptAccount.label" default="Concept Account" /></th>
				<th><g:message code="concept.conceptGroup.label" default="Concept Group" /></th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${conceptInstanceList}" status="i" var="conceptInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${conceptInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
			
				<td>${fieldValue(bean: conceptInstance, field: "code")}</td>
				<td>${fieldValue(bean: conceptInstance, field: "description")}</td>
				<td>${fieldValue(bean: conceptInstance, field: "conceptAccount")}</td>
				<td>${fieldValue(bean: conceptInstance, field: "conceptGroup")}</td>
			
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