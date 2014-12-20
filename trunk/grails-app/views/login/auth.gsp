
<!DOCTYPE html>
<html>

<head>
<meta name="layout" content="main" />
</head>

<body>

	<hr/>
	<div class="col-md-offset-4 col-md-2 text-center">
		<form action='/mgmt/j_spring_security_check' method='POST'
			id='loginForm'>
			<p>
				<label class="control-label" for='username'>Usuario</label>
			</p>
			<p>
				<input class="form-control" type='text' class='text_' name='j_username' id='username' />
			</p>
			<p>
				<label class="control-label" for='password'>Clave</label>
			</p>
			<p>
				<input class="form-control" type='password' class='text_' name='j_password' id='password' />
			</p>
			<p>
				<input class="btn btn-primary" type='submit' id="submit" value='Login' />
			</p>
		</form>
	</div>

</body>

</html>