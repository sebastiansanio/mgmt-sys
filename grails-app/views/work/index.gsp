
<%@ page import="mgmt.work.Work" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
</head>

<body>

<div class="row margin-top-medium">
<g:form action="search" method="get" >
<div class="col-md-2">
<g:field type="number" placeholder="${message(code:'work.code.label')}" class="form-control" name="code" value="${params.long('code')}" />
</div>
<div class="col-md-2">
<g:actionSubmit class="btn btn-default" value="${message(code:'default.search.label')}" action="search" />
</div>
</g:form>
</div>

<section id="index-work" class="first">

	<table class="table table-bordered margin-top-medium">
		<thead>
			<tr>
				<th class="center-aligned">${message(code:'default.edit.label')}</th>
				<g:sortableColumn class="center-aligned" params="${params}" property="code" title="${message(code: 'work.code.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="name" title="${message(code: 'work.name.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="type" title="${message(code: 'work.type.label')}" />
				<g:sortableColumn class="center-aligned" params="${params}" property="finished" title="${message(code: 'work.finished.label')}" />
				<th class="center-aligned"><g:message code="work.client.label" default="Client" /></th>
				<g:sortableColumn class="center-aligned" params="${params}" property="dateCreated" title="${message(code: 'budget.dateCreated.label', default: 'Date Created')}" />
				<sec:access url="/work/close">
				<th class="center-aligned"><g:message code="work.close.label" /></th>
				</sec:access>
				
				<sec:access url="/work/delete">
				<th class="center-aligned">${message(code:'default.button.delete.label')}</th>
				</sec:access>
			</tr>
		</thead>
		<tbody>
		<g:each in="${workInstanceList}" status="i" var="workInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				<td class="center-aligned"><g:link action="edit" id="${workInstance.id}"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
				<td>${workInstance.code}</td>
				<td>${fieldValue(bean: workInstance, field: "name")}</td>
				<td>${message(code:'work.type.'+workInstance.type)}</td>
				<td><g:formatBoolean boolean="${workInstance.finished}" /></td>
				<td>${fieldValue(bean: workInstance, field: "client")}</td>
				<td class="center-aligned"><g:formatDate date="${workInstance.dateCreated}" /></td>
				
				<g:if test="${!workInstance.finished}">
					<sec:access url="/work/close">
						<td class="center-aligned">
							<g:form action="close">
								<g:hiddenField name="id" value="${workInstance.id}" />
								<g:hiddenField name="max" value="${params.max}" />
								<g:hiddenField name="sort" value="${params.sort}" />
								<g:hiddenField name="order" value="${params.order}" />
								<g:hiddenField name="offset" value="${params.offset}" />
								<g:submitButton class="btn btn-danger btn-xs" name="close" value="${message(code:'work.close.label') }" /> 
							</g:form>
						</td>
					</sec:access>
				</g:if>
				<g:else>
					<sec:access url="/work/open">
						<td class="center-aligned">
							<g:form action="open">
								<g:hiddenField name="id" value="${workInstance.id}" />
								<g:hiddenField name="max" value="${params.max}" />
								<g:hiddenField name="sort" value="${params.sort}" />
								<g:hiddenField name="order" value="${params.order}" />
								<g:hiddenField name="offset" value="${params.offset}" />
								<g:submitButton class="btn btn-primary btn-xs" name="open" value="${message(code:'work.open.label') }" /> 
							</g:form>
						</td>
					</sec:access>
				</g:else>
				
				<sec:access url="/work/delete">
				<td class="center-aligned">
				<g:if test="${!workInstance.budget && !workInstance.movements}">
				<g:form action="delete">
					<g:hiddenField name="_method" value="DELETE" />
					<g:hiddenField name="id" value="${workInstance.id}" />
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
		<bs:paginate total="${workInstanceCount}" />
	</div>
</section>

</body>

</html>