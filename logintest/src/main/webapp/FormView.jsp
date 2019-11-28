<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" charset="utf-8">
<title>View Submitted Forms</title>
</head>
<body>
	<form>
		<h4>Form URL:</h4>
		<select class="form-control"  id='formSelect' name='formSelect' onClick="getFormSubmissions()"></select>

		<h4>Submission:</h4>
		<select class="form-control"  id='submissionSelect' name='submissionSelect'></select>
	</form>

	<button type="button" id="view-form" onclick = "getSub()">View Form Submission</button>

	<p></p>
        
        <p id = "Test">Choose an option:</p>

	<div class="fb-render">
		<textarea id="fb-template">
			<form-template></form-template>
		</textarea>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://formbuilder.online/assets/js/form-render.min.js"></script>
	<script>
		const viewFormBtn = document.getElementById("view-form");
		//viewFormBtn.addEventListener(
		//	"click",
		//	() => 
//                                var xhttp = new XMLHttpRequest();
//                                xhttp.onreadystatechange = function()
//                                {
//                                  if(this.readyState == 4 && this.status == 200)
//                                  {
//                                    document.getElementById("Test").innerHTML = this.responseText;
//                                  }
//                                  else
//                                  {
//                                    window.alert("Failed to get submission from the server");
//                                  }
//                                };
//                                xhttp.open("GET", "FormViewController", true);
//                                xhttp.send();
//                              },
                        function getSub(){
                            document.getElementById("invisi-press").value = "pressed";
                            document.getElementById("invisi-press").innerHTML = "pressed";
				getSubmission();
                                
                                $.ajax({
                                   type:"GET",
                                   url:"FormViewController",
                                   data: {
                                       view_form: "yes"
                                   },
                                   success: function() {
                                       console.log("in ajax function");
                                       var xhttp = new XMLHttpRequest();
                                       xhttp.open("GET", "FormViewController", true);
                                       xhttp.send();
                                       console.log(${test_att});
                                   }
                                });
                                
                            //document.getElementById("invisi-press").value = "notpressed";
                            //document.getElementById("invisi-press").innerHTML = "notpressed";
			}
                        //,
			// false
		// );
		var submittedFormData = [];
		$(document).ready(function () { // Populate formList
			var formList = document.getElementById('formSelect');
                        var array = ${url_array};
                        var submissions = "";
                        
			for(var i = 0; i < ${num_urls}; i++)
			{
				console.log(i);
                                // var str = "";
                                //console.log(str);
                                // <c:forTokens items="${url_array}"; var="unique_url">
                                //     formList.options[i] = new Option("${url}");
                                // </c:forTokens>
				//formList.options[i] = new Option(${url_array.get(i)});
			}
                        
                        var i = 0;
                        array.forEach(function(entry) {
                            console.log(entry);
                            formList.options[i] = new Option(entry);
                            i++;
                        });
		});
		function getFormSubmissions()
		{
			$(document).ready(function () { // Populate submissionList
				var submissionList = document.getElementById('submissionSelect');
				// var subLength = number of form submissions for form in database;
				var subLength = 12; // placeholder
				console.log("clickity clackity");
				var i;
				for(i = 0; i < subLength; i++)
				{
					submissionList.options[i] = new Option('Submission # ' + i);
				}
			});
		}
		function getSubmission()
		{
			// submittedFormData = list of forms from database[formList.selectedIndex][submissionList.selectedIndex];
			submittedFormData = [{"type":"checkbox-group","required":true,"label":"checko mehico","name":"checkbox-group-1574027405290","values":[{"label":"Option 1","value":"option-1"},{"label":"Option 2","value":"option-2"},{"label":"Option 3","value":"option-3"}],"userData":["option-1","option-2","option-3"],"disabled":true},{"type":"date","required":true,"label":"dato dato","className":"form-control","name":"date-1574029037726","userData":["2019-11-24"],"disabled":true},{"type":"file","required":true,"label":"File Upload<br><a href=\"tester.jpg\" target=\"_blank\">Download File</a>","className":"form-control","name":"file-1574027410621","subtype":"file","disabled":true},{"type":"number","required":true,"label":"numero","className":"form-control","name":"number-1574028946834","userData":["222"],"disabled":true},{"type":"radio-group","required":true,"label":"rodeo radio","name":"radio-group-1574029006581","values":[{"label":"Option 1","value":"option-1"},{"label":"Option 2","value":"option-2"},{"label":"Option 3","value":"option-3"}],"userData":["option-3"],"disabled":true},{"type":"select","required":true,"label":"selecto mundo","className":"form-control","name":"select-1574027398028","values":[{"label":"Option 1","value":"option-1","selected":true},{"label":"Option 2","value":"option-2"},{"label":"Option 3","value":"option-3"}],"userData":["option-2"],"disabled":true},{"type":"text","required":true,"label":"texto t-trexto","className":"form-control","name":"text-1574027401302","subtype":"text","userData":["Here be the text"],"disabled":true},{"type":"textarea","required":true,"label":"paragraphical interface","className":"form-control","name":"textarea-1574029133288","subtype":"textarea","userData":["And o'er here\r\nbe the paragraphs\r\nof endless days"],"disabled":true},{"type":"hidden","name":"hidden-1574202434916","userData":[""],"disabled":true}];
			// ^ Placeholder
			// Render form submission
			jQuery(function($)
			{
				var fbTemplate = document.getElementById('fb-template');
				$('.fb-render').formRender({
					dataType: 'json',
					formData: submittedFormData
				});
			});
		}
		// Note - checkbox selections, when field required, do not render; issue with formBuilder https://github.com/kevinchappell/formBuilder/issues/910
	</script>
                        
                        <input type="text" name="invisi-press" id="invisi-press"></input>
</body>
</html>