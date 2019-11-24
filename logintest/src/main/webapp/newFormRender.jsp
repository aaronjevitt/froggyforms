<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Example Blank Form Render</title>
</head>
<body>
	<form id="fb-render"></form>
	<button type="button" id="get-user-data" name="submit-form">Get Updated formData</button>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://formbuilder.online/assets/js/form-render.min.js"></script>
	<script>
		const getUserDataBtn = document.getElementById("get-user-data");
		const fbRender = document.getElementById("fb-render");
		const originalFormData = [
			{
				"type": "checkbox-group",
				"required": true,
				"label": "checko mehico",
				"name": "checkbox-group-1574027405290",
				"values": [
					{
						"label": "Option 1",
						"value": "option-1"
					},
					{
						"label": "Option 2",
						"value": "option-2"
					},
					{
						"label": "Option 3",
						"value": "option-3"
					}
				]
			},
			{
				"type": "date",
				"required": true,
				"label": "dato dato",
				"className": "form-control",
				"name": "date-1574029037726"
			},
			{
				"type": "file",
				"required": true,
				"label": "File Upload",
				"className": "form-control",
				"name": "file-1574027410621",
				"subtype": "file"
			},
			{
				"type": "number",
				"required": true,
				"label": "numero",
				"className": "form-control",
				"name": "number-1574028946834"
			},
			{
				"type": "radio-group",
				"required": true,
				"label": "rodeo radio",
				"name": "radio-group-1574029006581",
				"values": [
					{
						"label": "Option 1",
						"value": "option-1"
					},
					{
						"label": "Option 2",
						"value": "option-2"
					},
					{
						"label": "Option 3",
						"value": "option-3"
					}
				]
			},
			{
				"type": "select",
				"required": true,
				"label": "selecto mundo",
				"className": "form-control",
				"name": "select-1574027398028",
				"values": [
					{
						"label": "Option 1",
						"value": "option-1",
						"selected": true
					},
					{
						"label": "Option 2",
						"value": "option-2"
					},
					{
						"label": "Option 3",
						"value": "option-3"
					}
				]
			},
			{
				"type": "text",
				"required": true,
				"label": "texto t-trexto",
				"className": "form-control",
				"name": "text-1574027401302",
				"subtype": "text"
			},
			{
				"type": "textarea",
				"required": true,
				"label": "paragraphical interface",
				"className": "form-control",
				"name": "textarea-1574029133288",
				"subtype": "textarea"
			}
		];
		
		// Check that all required fields are filled out
		function validate()
		{
			var length = $(fbRender).formRender("userData").length;
			var i;
			for(i = 0; i < length; i++) // Go through each field
			{
				console.log($(fbRender).formRender("userData")[i]);
				if($(fbRender).formRender("userData")[i].required === true)
				{
					switch ($(fbRender).formRender("userData")[i].type)
					{
						case "checkbox-group":
							if(!$(fbRender).formRender("userData")[i].userData)
							{
								return false; // maybe return type to fill out?
							}
							break;
						
						case "date":
							if(!$(fbRender).formRender("userData")[i].userData[0])
							{
								return false;
							}
							break;
						
						/* can't implement currently - nothing stored
						case "file":
							break;
						*/
						
						case "number":
							if(!$(fbRender).formRender("userData")[i].userData[0])
							{
								return false;
							}
							break;
						
						case "radio-group":
							if(!$(fbRender).formRender("userData")[i].userData)
							{
								return false;
							}
							break;
						
						case "select":
							if($(fbRender).formRender("userData")[i].userData[0] 
								=== $(fbRender).formRender("userData")[i].values[0].value)
							{
								return false;
							}
							break;
						
						
						case "text":
							if(!$(fbRender).formRender("userData")[i].userData[0])
							{
								return false;
							}
							break;
						
						case "textarea":
							if(!$(fbRender).formRender("userData")[i].userData[0])
							{
								return false;
							}
							break;
						
						default:
							console.log("Non-implemented type");
							break;
					}
				}
			}
			
			return true;
		}
		
		jQuery(function($) {
		  const formData = JSON.stringify(originalFormData);
		  $(fbRender).formRender({ formData });
		  getUserDataBtn.addEventListener(
			"click",
			() => {
				if(validate() === true)
				{
					// "submit"
					window.alert(window.JSON.stringify($(fbRender).formRender("userData")));
				}
				else
				{
					window.alert("Please fill in all required forms before submitting");
				}
			},
			false
		  );
		});
	</script>
</body>
</html>