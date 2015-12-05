<!DOCTYPE html>
<html>

<head>
	<meta name="layout" content="main" />
</head>

<body>

<hr/>

<g:uploadForm action="importData">

<g:select class="form-control" name="datatype" from="['concepts','suppliers','works','invoiceType','accounts','clients','budgetItems','movement','movementItems','payment','supplierBudget']" />

<input class="form-control" type="file" name="file" />

<g:submitButton class="btn" name="Importar"/>


</g:uploadForm>


</body>

</html>