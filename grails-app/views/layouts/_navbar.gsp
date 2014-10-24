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
					<li><g:form controller="logout"><g:submitButton name="Submit" value="Salir" class="btn btn-primary" /></g:form></li>
				</ul>
			</div>
		</sec:ifLoggedIn>
	</div>
</nav>