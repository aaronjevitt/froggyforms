<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>FroggyFormBuilder</title>
	<style>
	body{
	  background-image: url("builderFrog.jpg");
	  background-repeat: round;
	}
	</style>
</head>
<body>
	<div id="fb-editor"></div>

	<form action="FroggyPublisher" method="post">
		<div>
			<button type="button" id="publishButton">Publish Form</button>
			<div id="jsonString" name="jsonString" style="visibility: hidden;"></div>
		</div>
	</form>



	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://formbuilder.online/assets/js/form-builder.min.js"></script>

	<script>
	</script>
	<script>
		jQuery(function($)
		{

		$(document.getElementById('fb-editor')).formBuilder();

		var fbEditor = document.getElementById('build-wrap');
		var formBuilder = $(fbEditor).formBuilder();

		document.getElementById('publishButton').addEventListener('click', function()
		{
			var frogData = (formBuilder.actions.getData('json'));
			console.log(frogData);
			if(frogData == "[]")
			{
				alert("You can not publish an empty form.");
			}
			// var jsonText = document.getElementById("jsonString");
			// jsonText.innerHTML = frogData;
			document.getElementById("jsonString").innerHTML = frogData;
		});

		});
	</script>
</body>
</html>
