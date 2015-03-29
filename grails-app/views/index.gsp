<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
	</head>
	<body>
		<div>
			<h3>
			Bienvenido ${mgmt.security.SecUser.findByUsername(sec.loggedInUserInfo(field:"username")).name}
			</h3>
		</div>
	</body>
</html>
