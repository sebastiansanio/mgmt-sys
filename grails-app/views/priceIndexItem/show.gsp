
<%@ page import="mgmt.index.PriceIndexItem"%>
<!DOCTYPE html>
<html>

<head>
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'priceIndexItem.label', default: 'PriceIndexItem')}" />
</head>

<body>

	<section id="show-priceIndexItem" class="first">

		<table class="table">
			<tbody>

				<tr class="prop">
					<td valign="top" class="name"><g:message
							code="priceIndexItem.date.label" default="Date" /></td>

					<td valign="top" class="value"><g:formatDate
							date="${priceIndexItemInstance?.date}" /></td>

				</tr>


				<tr class="prop">
					<td valign="top" class="name"><g:message
							code="priceIndexItem.index.label" default="Index" /></td>

					<td valign="top" class="value"><g:link controller="priceIndex"
							action="show" id="${priceIndexItemInstance?.index?.id}">
							${priceIndexItemInstance?.index?.encodeAsHTML()}
						</g:link></td>

				</tr>

				<tr class="prop">
					<td valign="top" class="name"><g:message
							code="priceIndexItem.indexValue.label" /></td>

					<td valign="top" class="value">
						${priceIndexItemInstance.indexValue }
					</td>

				</tr>


				<tr class="prop">
					<td valign="top" class="name"><g:message
							code="default.dateCreated.label" /></td>

					<td valign="top" class="value"><g:formatDate
							date="${priceIndexItemInstance?.dateCreated}" /></td>

				</tr>

				<tr class="prop">
					<td valign="top" class="name"><g:message
							code="default.lastUpdated.label" /></td>

					<td valign="top" class="value"><g:formatDate
							date="${priceIndexItemInstance?.lastUpdated}" /></td>

				</tr>

			</tbody>
		</table>
	</section>

</body>

</html>