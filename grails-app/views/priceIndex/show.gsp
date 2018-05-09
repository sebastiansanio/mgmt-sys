
<%@ page import="mgmt.index.PriceIndex" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'priceIndex.label', default: 'PriceIndex')}" />
</head>

<body>

<section id="show-priceIndex" class="first">

	<table class="table">
		<tbody>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="priceIndex.name.label" default="Name" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: priceIndexInstance, field: "name")}</td>
				
			</tr>

			<tr class="prop">
				<td valign="top" class="name"><g:message code="priceIndex.description.label" default="Description" /></td>
				
				<td valign="top" class="value">${fieldValue(bean: priceIndexInstance, field: "description")}</td>
				
			</tr>
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="priceIndex.items.label" default="Items" /></td>
				
				<td valign="top" style="text-align: left;" class="value">
					<ul>
					<g:each in="${priceIndexInstance.items}" var="i">
						<li><g:formatDate date="${i.date}" />:${i.indexValue} </li>
					</g:each>
					</ul>
				</td>
				
			</tr>
			
			<tr class="prop">
				<td valign="top" class="name"><g:message code="priceIndex.frequency.label" /></td>
				
				<td valign="top" class="value">${message(code: 'priceIndex.frequency.'+priceIndexInstance?.frequency)}</td>
			</tr>
					
			<tr class="prop">
				<td valign="top" class="name"><g:message code="default.dateCreated.label" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${priceIndexInstance?.dateCreated}" /></td>
				
			</tr>
		
		
			<tr class="prop">
				<td valign="top" class="name"><g:message code="default.lastUpdated.label" /></td>
				
				<td valign="top" class="value"><g:formatDate date="${priceIndexInstance?.lastUpdated}" /></td>
				
			</tr>
			
		
		</tbody>
	</table>
</section>

</body>

</html>