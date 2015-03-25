<!DOCTYPE html>
<html lang="${session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'}">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">

<title>${message(code:'appName.label')}</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

<asset:stylesheet src="bootstrap.min.css" />
<asset:stylesheet src="datepicker3.css" />
<asset:stylesheet src="styles.css" />
<asset:stylesheet src="chosen.min.css" />


<asset:javascript src="bootstrap.min.js" />
<asset:javascript src="bootstrap-datepicker.js" />
<asset:javascript src="scripts.js" />
<asset:javascript src="chosen.jquery.min.js" />
<g:layoutHead />
</head>
<body>

	<g:render template="/layouts/navbar" />
	<div class="container-fluid">
		<div class="row">
			<g:render template="/layouts/menu" />
		</div>
		<div class="row">
			<div class="col-margin-left col-margin-right" >
				<g:if test="${!noSubMenu}" >
					<g:render template="/layouts/submenu" />
				</g:if>
				
				<g:if test="${flash.error}">
					<div class="alert alert-danger">${flash.error}</div>
				</g:if>
				<g:if test="${flash.message}">
					<div class="alert alert-info">${flash.message}</div>
				</g:if>
				
				<g:layoutBody />
			</div>
		</div>
	</div>

</body>
</html>