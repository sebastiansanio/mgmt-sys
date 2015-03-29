
<%@ page import="mgmt.security.Requestmap" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'requestmap.label', default: 'Requestmap')}" />
</head>

<body>

<section id="show-requestmap" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="requestmap.url.label" default="Url" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: requestmapInstance, field: "url")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="requestmap.configAttribute.label" default="Config Attribute" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: requestmapInstance, field: "configAttribute")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="requestmap.httpMethod.label" default="Http Method" /></td>
				
				<td valign="top" class="value">${requestmapInstance?.httpMethod?.encodeAsHTML()}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>