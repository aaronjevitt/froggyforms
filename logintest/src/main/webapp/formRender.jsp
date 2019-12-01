<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Froggy Forms</title>
</head>
<body>
	<form id="fb-render" method="post" action="submit"></form>
	<button type="button" id="get-user-data" name="submit-form" onclick="performAjaxSubmit()">Submit</button>
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
							break;
					}
				}
			}
			
			return true;
		}
                
                                 function performAjaxSubmit() {
                        if(validate() === true)
				{
					var datastring = JSON.stringify($(fbRender).formRender("userData"));
                                        console.log("bloop");
                                        var form = document.getElementById("fb-render");
                                        console.log(form);
                                        var formData = new FormData(form);
                                        console.log(formData);
                                        formData.append("unique_url", "${uniqurl}");
                                        formData.append("formjson", datastring);
                                        var xhr = new XMLHttpRequest();       

                                        xhr.open("POST","submit", true);

                                        xhr.send(formData);

                                        xhr.onload = function(e) {

                                            if (this.status === 200) {

                                               renderSuccessForm();
                                               getUserDataBtn.hidden = "hidden";
                                            }

                                        };   
                                        }
				else
				{
					window.alert("Please fill in all required forms before submitting");
				}
                

    }   
		
		jQuery(function($) {
                  const datadata = ${formdata};
		  const formData = JSON.stringify(datadata);
		  $(fbRender).formRender({ formData });

		});
                
                
                    function renderSuccessForm()
    {
        console.log("bloop");
        var FormData = [{"type":"header","subtype":"h1","label":"Form was successfully submitted. You may close this tab."}];
        jQuery(function($)
        {
            $(fbRender).formRender({
                        dataType: 'json',
                        formData: FormData
                });
        });
    }
	</script>
</body>
</html>