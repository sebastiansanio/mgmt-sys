
<%@ page import="mgmt.persons.Client" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
</head>

<body>

<div class="row">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:textField placeholder="${message(code:'client.name.label')}" class="form-control" name="name" value="${params.name}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="search" />
</div>
</g:form>
</div>

<section id="index-client" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.show.label')}</th>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="name" title="${message(code: 'client.name.label', default: 'Name')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="businessName" title="${message(code: 'client.businessName.label', default: 'Business Name')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="cuit" title="${message(code: 'client.cuit.label', default: 'Cuit')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="address" title="${message(code: 'client.address.label', default: 'Address')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="location" title="${message(code: 'client.location.label', default: 'Location')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="province" title="${message(code: 'client.province.label', default: 'Province')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="zipCode" title="${message(code: 'client.zipCode.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="note" title="${message(code: 'client.note.label')}" />
				
			</tr>
		</thead>
		<tbody>
		<g:each in="${clientInstanceList}" status="i" var="clientInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="show" id="${clientInstance.id}"><span class="glyphicon glyphicon-eye-open"></span></g:link></td>
				<td class="center-aligned"><g:link action="edit" id="${clientInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
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