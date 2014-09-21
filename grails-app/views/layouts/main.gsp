<!DOCTYPE html>
<html lang="${session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'}">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">

<title>${message(code:'appName.label')}</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">

<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}"
	type="image/x-icon">
<link rel="apple-touch-icon"
	href="${assetPath(src: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114"
	href="${assetPath(src: 'apple-touch-icon-retina.png')}">
<asset:stylesheet src="bootstrap.min.css" />
<asset:javascript src="bootstrap.min.js" />
<asset:stylesheet src="styles.css" />
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
