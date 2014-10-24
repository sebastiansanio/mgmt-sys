<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">
				${message(code:'appName.label')}
			</a>
		</div>
		<sec:ifLoggedIn>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#">Salir</a></li>
				</ul>
			</div>
		</sec:ifLoggedIn>
	</div>
</nav>