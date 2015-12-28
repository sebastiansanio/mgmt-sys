
<%@ page import="mgmt.security.Requestmap" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'requestmap.label', default: 'Requestmap')}" />
</head>

<body>

<section id="index-requestmap" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.edit.label')}</th>
				<g:sortableColumn property="url" title="${message(code: 'requestmap.url.label', default: 'Url')}" />
				<g:sortableColumn property="configAttribute" title="${message(code: 'requestmap.configAttribute.label', default: 'Config Attribute')}" />
				<g:sortableColumn property="httpMethod" title="${message(code: 'requestmap.httpMethod.label', default: 'Http Method')}" />
			</tr>
		</thead>
		<tbody>
		<g:each in="${requestmapInstanceList}" status="i" var="requestmapInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="edit" id="${requestmapInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: requestmapInstance, field: "url")}</td>
				<td>${fieldValue(bean: requestmapInstance, field: "configAttribute")}</td>
				<td>${fieldValue(bean: requestmapInstance, field: "httpMethod")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${requestmapInstanceCount}" />
	</div>
</section>

</body>

</html>