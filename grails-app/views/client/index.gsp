
<%@ page import="mgmt.persons.Client" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
</head>

<body>

<section id="index-client" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th>${message(code:'default.show.label')}</th>
				<g:sortableColumn property="name" title="${message(code: 'client.name.label', default: 'Name')}" />
				<g:sortableColumn property="businessName" title="${message(code: 'client.businessName.label', default: 'Business Name')}" />
				<g:sortableColumn property="cuit" title="${message(code: 'client.cuit.label', default: 'Cuit')}" />
				<g:sortableColumn property="address" title="${message(code: 'client.address.label', default: 'Address')}" />
				<g:sortableColumn property="location" title="${message(code: 'client.location.label', default: 'Location')}" />
				<g:sortableColumn property="province" title="${message(code: 'client.province.label', default: 'Province')}" />
				<g:sortableColumn property="province" title="${message(code: 'client.zipCode.label')}" />
				<g:sortableColumn property="province" title="${message(code: 'client.note.label')}" />
				
			</tr>
		</thead>
		<tbody>
		<g:each in="${clientInstanceList}" status="i" var="clientInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td><g:link action="show" id="${clientInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td>${fieldValue(bean: clientInstance, field: "name")}</td>
				<td>${fieldValue(bean: clientInstance, field: "businessName")}</td>
				<td>${fieldValue(bean: clientInstance, field: "cuit")}</td>
				<td>${fieldValue(bean: clientInstance, field: "address")}</td>
				<td>${fieldValue(bean: clientInstance, field: "location")}</td>
				<td>${fieldValue(bean: clientInstance, field: "province")}</td>
				<td>${fieldValue(bean: clientInstance, field: "zipCode")}</td>
				<td>${fieldValue(bean: clientInstance, field: "note")}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${clientInstanceCount}" />
	</div>
</section>

</body>

</html>