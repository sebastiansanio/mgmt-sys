
<%@ page import="mgmt.core.Concept" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'concept.label', default: 'Concept')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>

<body>

<section id="show-concept" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: conceptInstance, field: "code")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="concept.description.label" default="Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: conceptInstance, field: "description")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>