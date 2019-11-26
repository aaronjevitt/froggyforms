<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Example Submitted Form Render</title>
</head>
<form action="AdminPage" method="post">
<body>
	<div class="fb-render">
		<textarea id="fb-template">
			<form-template>
				<fields>
					<field name="select-1454177070204" label="Select" style="multiple" description="" required="false" className="form-control" type="select">
						<option value="option-1">Option 1</option> <option value="option-2">Option 2</option>
					</field>
					<field name="rich-text-1454177067296" label="Text Area" description="" className="form-control" required="false" type="textarea"/>
				</fields>
			</form-template>
		</textarea>
	</div>


	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://formbuilder.online/assets/js/form-render.min.js"></script>
	<script>
		/*
		// for blank form
		jQuery(function($)
		{
			var fbTemplate = document.getElementById('fb-template');
			$('.fb-render').formRender(
			{
				dataType: 'xml',
				formData: fbTemplate.value
			});
		});
		*/

		// for filled-out form
		jQuery(function($) 
		{
			var fbTemplate = document.getElementById('fb-template');
			$('.fb-render').formRender({
				dataType: 'xml',
				formData: [ // here's where we copied the filled out form shiz
					{
						"name": "select-1454177070204",
						"label": "Select",
						"style": "multiple",
						"className": "form-control",
						"type": "select",
						"values": [
							{
								"value": "option-1",
								"label": "Option 1"
							},
							{
								"value": "option-2",
								"label": "Option 2"
							}
						],
						"userData": [
							"option-2"
						]
					},
					{
						"name": "rich-text-1454177067296",
						"label": "Text Area",
						"className": "form-control",
						"type": "textarea",
						"userData": [
							"stuffity stuff"
						]
					}
				]
			});
		});

	</script>
</body>
</html>