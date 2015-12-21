<nav class="navbar navbar-inverse navbar-fixed-top" >
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">
				<img height="32px" src="${resource(dir: 'images', file: 'Logo Urbatec.png')}" /> 	
			</a>
		</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
				<sec:ifLoggedIn>
					<li><g:form controller="logout"><g:submitButton name="Submit" value="Salir" class="btn btn-default" /></g:form></li>
				</sec:ifLoggedIn>
				</ul>
			</div>
	</div>
</nav>