
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Example Blank Form Render</title>
</head>
<body>
	<form id="fb-render" method="post" action="submit"></form>
	<button type="button" id="get-user-data" name="submit-form">Get Updated formData</button>
	<input type="submit" form="fb-render" />
 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://formbuilder.online/assets/js/form-render.min.js"></script>
	<script>
		const getUserDataBtn = document.getElementById("get-user-data");
		const fbRender = document.getElementById("fb-render");
		
		
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
        /*        
                 function performAjaxSubmit() {

        var datastring = JSON.stringify($(fbRender).formRender("userData"));

        var form = document.getElementById('fb-render');
        var formData = new FormData(form);
        formData.append("formjson", datastring);
        var xhr = new XMLHttpRequest();       

        xhr.open("POST","submit", true);

        xhr.send(formdata);

        xhr.onload = function(e) {

            if (this.status == 200) {

               alert(this.responseText);

            }

        };                    

    }   
    
         */
		
		jQuery(function($) {
                  const datadata = ${formdata};
		  const formData = JSON.stringify(datadata);
		  $(fbRender).formRender({ formData });
		  getUserDataBtn.addEventListener(
			"click",
			() => {
				if(validate() === true)
				{
					//performAjaxSubmit();
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
                  
                  
</body>
</html>

