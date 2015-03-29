
<%@ page import="mgmt.security.SecAuthority" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'secAuthority.label', default: 'SecAuthority')}" />
</head>

<body>

<section id="show-secAuthority" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="secAuthority.authority.label" default="Authority" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: secAuthorityInstance, field: "authority")}</td>
				
			</tr>
		
		</tbody>
	</table>
</section>

</body>

</html>