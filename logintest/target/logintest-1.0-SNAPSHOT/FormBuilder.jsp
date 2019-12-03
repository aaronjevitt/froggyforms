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
	<div id="fb-editor"></div>

        <div>
            <button type="button" id="publisher" onclick="">Publish Form!</button>
        </div>
	<form action="FroggyPublisher" method="post">
		<div>
			<button type="submit" id="publishButton" style="visibility: hidden"></button>
			<input type="text" id="jsonString" name="jsonString" style="visibility: hidden"></input>
		</div>
	</form>

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
        </script>

	<script>
		jQuery(function($)
		{

//		$(document.getElementById('fb-editor')).formBuilder();
//
//		var fbEditor = document.getElementById('build-wrap'),
//                fbOptions = {
//                disabledActionButtons: ['data', 'save'],
//
//                },
//                formBuilder = $fbEditor.formBuilder(fbOptions);
//		// var formBuilder = $(fbEditor).formBuilder(fbOptions);
                
                
                
		document.getElementById('publisher').addEventListener('click', function()
		{
			var frogData = (formBuilder.actions.getData('json'));
			console.log(frogData);
			if(frogData == "[]")
			{
				alert("You cannot publish an empty form.");
			}
                        else
                        {
                                document.getElementById("jsonString").value = frogData;
                        }
                        
                        // document.getElementById("publishButton").style.visibility = "visible";
                         document.getElementById("publishButton").click();
                        //$.post("FormBuilder.jsp", frogData, function() { alert(frogData); });
			
		});

//                function publish()
//                {
//                    var frogData = (formBuilder.actions.getData('json'));
//                    console.log(frogData);
//                    if(frogData == "[]")
//                    {
//                    	alert("You can not publish an empty form.");
//                    }
//                    else
//                    {
//                        document.getElementById("jsonString").innerHTML = frogData;
//                    }
//                }
		});
	</script>
</body>
</html>
