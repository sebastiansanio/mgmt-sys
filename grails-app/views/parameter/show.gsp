
<%@ page import="mgmt.config.Parameter" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'parameter.label', default: 'Parameter')}" />
</head>

<body>

<section id="show-parameter" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="parameter.code.label" default="Code" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: parameterInstance, field: "code")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="parameter.value.label" default="Value" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: parameterInstance, field: "value")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>