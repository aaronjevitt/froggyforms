<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name=?viewport? content=?width=device-width, initial-scale=1?>
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
    	<form id="form" action="FroggyPublisher" method="post">
		<div>
                    <label for="title">Choose a url(must be unique) or leave blank for random url</label>
                    	<input type="text" name=faketitle" id="faketitle" autocomplete="off"/>
                        <label id="errorlabel" style="visibility: hidden">Please Choose a unique URL<>
			<input type="text" id="jsonString" name="jsonString" style="visibility: hidden"></input>
                        <input type="text" id="title" name="title" style="visibility: hidden"></input>

		</div>
	</form>
	<div id="fb-editor"></div>

        <div>
            <button type="button" id="publisher" onclick="submitform()">Publish Form!</button>
        </div>


	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://formbuilder.online/assets/js/form-builder.min.js"></script>

        <script>
        var $fbEditor = $(document.getElementById('fb-editor')),
       // $formContainer = $(document.getElementById('fb-rendered-form')),
        fbOptions = {
          disabledActionButtons: ['data', 'save'],

        },
        formBuilder = $fbEditor.formBuilder(fbOptions);
            
                function submitform()
                {
                    var form = document.getElementById("form");
                    var formData = new FormData(form);
                    
                    var frogData = (formBuilder.actions.getData('json'));
			console.log(frogData);
			if(frogData === "[]")
			{
				alert("You cannot publish an empty form.");
			}
                        else
                        {   
                            console.log("url " + document.getElementById("faketitle").value);
                            var xhr = new XMLHttpRequest();     
                            formData.append("unique_url",document.getElementById("faketitle").value);
                            xhr.open("POST","checkurl", true);
                            xhr.send(formData);
                            xhr.onload = function(e) 
                            {
                                
                               console.log(this.responseText);
                               debugger;
                               if (this.responseText.localeCompare("1") === 0)
                               {
                                   console.log(this.responseText);
                                   alert("This URL already exists please try again");
                               }
                               else if (this.responseText.localeCompare("2")===0)
                               {
                                   alert("URL cannot begin with a space");
                               }
                               else
                               {
                                    document.getElementById("jsonString").value = frogData;
                                    document.getElementById("title").value = document.getElementById("faketitle").value;
                                    document.getElementById("form").submit();
                               }
                            };   

                        }
                }     
	</script>
</body>
</html>
