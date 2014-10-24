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

<asset:javascript src="bootstrap.min.js" />
<asset:javascript src="bootstrap-datepicker.js" />
<asset:javascript src="scripts.js" />
<g:layoutHead />
</head>
<body>

	<g:render template="/layouts/navbar" />
	<div class="container-fluid">
		<div class="row row-offcanvas row-offcanvas-left">
			<div class="col-sm-3 col-md-2 sidebar-offcanvas" id="sidebar" role="navigation">
				<g:render template="/layouts/menu" />
			</div>
			<div class="col-sm-8 col-md-8 main">
				<g:render template="/layouts/submenu" />
				<g:layoutBody />
			</div>
		</div>
	</div>

</body>
</html>