
<%@ page import="mgmt.account.Account" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
</head>

<body>

<div class="row margin-top-medium">
<g:form action="index" method="get" >
<div class="col-md-2">
<g:select class="form-control" from="['all','active']" valueMessagePrefix="account.status" name="statusFilter" value="${params.statusFilter}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.filter.label')}" action="index" />
</div>
</g:form>
</div>


<section id="index-account" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" property="code" title="${message(code: 'account.code.label')}" />
				<g:sortableColumn class="center-aligned" property="name" title="${message(code: 'account.name.label')}" />
				<g:sortableColumn class="center-aligned" property="type.name" title="${message(code: 'account.type.label')}" />
				<g:sortableColumn class="center-aligned" property="dateCreated" title="${message(code: 'account.dateCreated.label')}" />
				<sec:access url="/tr/delete">
				<th class="center-aligned">${message(code:'default.button.delete.label')}</th>
				</sec:access>			
			</tr>
		</thead>
		<tbody>
		<g:each in="${accountInstanceList}" status="i" var="accountInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="edit" id="${accountInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${fieldValue(bean: accountInstance, field: "code")}</td>
				<td>${fieldValue(bean: accountInstance, field: "name")}</td>
				<td>${fieldValue(bean: accountInstance, field: "type")}</td>
				<td class="center-aligned"><g:formatDate date="${accountInstance.dateCreated}"/></td>
				
				<sec:access url="/account/delete">
				<td class="center-aligned">
				<g:if test="${!accountInstance.payments}">
				<g:form action="delete">
					<g:hiddenField name="_method" value="DELETE" />
					<g:hiddenField name="id" value="${accountInstance.id}" />
					<button onclick="if(!confirm('${message(code:'default.delete.confirm.message')}')) event.preventDefault();" class="btn btn-danger btn-xs" name="delete"><span class="glyphicon glyphicon-trash"></span> </button>
				</g:form>
				</g:if>
				</td>
				</sec:access>
			</tr>
		</g:each>
		</tbody>
	</table>
	<div>
		<bs:paginate total="${accountInstanceCount}" params="${params}" />
	</div>
</section>

</body>

</html>