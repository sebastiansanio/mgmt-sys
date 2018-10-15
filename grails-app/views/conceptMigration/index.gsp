
<%@ page import="mgmt.concept.ConceptGroup" %>
<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>

<section id="index-conceptGroup" class="first">

		<g:form action="migrate" class="form-horizontal" role="form" >
			<div class="row">
			<div class="col-md-4">
				
				<div>
					<label for="conceptFrom" class="control-label"><g:message code="conceptMigration.conceptFrom.label" /></label>
					<div>
						<g:select class="form-control" id="conceptFrom" name="conceptFrom" from="${mgmt.concept.Concept.list([sort:'code',order:'asc'])}" optionKey="id" required="" />
					</div>
				</div>
				
				<div>
					<label for="name" class="control-label"><g:message code="conceptMigration.conceptTo.label"  /></label>
					<div>
						<g:select class="form-control" id="conceptTo" name="conceptTo" from="${mgmt.concept.Concept.list([sort:'code',order:'asc'])}" optionKey="id" required="" />
					</div>
				</div>
			
			</div>
			</div>
			<hr/>
			<div class="form-actions margin-top-medium">
				<g:submitButton name="migrate" onclick="validateForm(event);" class="btn btn-primary" value="${message(code: 'conceptMigration.migrate.label')}" />
			</div>
		</g:form>

</section>
<script>

function validateForm(event){
	if($('#conceptFrom').val() == $('#conceptTo').val()){
		alert('${message(code:'conceptMigration.sameConcept.error')}');
		event.preventDefault();
		return;
	}


	if(!confirm('${message(code:'conceptMigration.confirm.message')}'.replace('conceptFrom',$( "#conceptFrom option:selected" ).text()).replace('conceptTo',$( "#conceptTo option:selected" ).text())   )){
		event.preventDefault();
		return;
	}
}


</script>

</body>


</html>