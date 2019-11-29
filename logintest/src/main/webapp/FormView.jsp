<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" charset="utf-8">
<title>View Submitted Forms</title>
</head>
<body>
	<form id="form">
            
		<h4>Form URL:</h4>
		<select class="form-control"  id='formSelect' name='formSelect' onClick="getFormSubmissions()"></select>

		<h4>Submission:</h4>
                <select class="form-control"  id='submissionSelect' name='submissionSelect' onClick="getFormSubmission()"></select>
               
                <button type="button" class="form-control" id='deletesub' name='deletesub' onClick='deletecurrentsubmission()' disabled='true'>Delete Submission</button>
                <button type="button" class="form-control" id='deleteform' name='deleteform' onClick='deletecurrentform()' disabled='true'>Delete Form</button>
	</form>

	<div class="form1" id = "form1">
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://formbuilder.online/assets/js/form-render.min.js"></script>
	<script>
                getForms();

                function getForms()
                {
                    $(document).ready(function () { // Populate submissionList
                        
                                var form = document.getElementById("form");
                                var activeform = document.getElementById("formSelect");
				var submissionList = document.getElementById('submissionSelect');
				var formData = new FormData(form);
                                submissionList.options.length = 0;
                                var response;
                                activeform.options.length=0;
                                        var xhr = new XMLHttpRequest();       

                                        xhr.open("POST","formlist", true);

                                        xhr.send(formData);

                                        xhr.onload = function(e) {

                                            if (this.status == 200) {
                                               response = this.responseText;
                                               var forms = JSON.parse(response);
                                               //getSubmission(response);
                                               forms.forEach(myFunction); 
                                                function myFunction(item) 
                                                { 
                                                    activeform.options[activeform.options.length] = new Option(item);
                                                    console.log(submissionList.options.value)
                                                    
                                            }
                                            if(activeform.options.length !== 0)
                                            {
                                            getFormSubmissions();
                                            }
                                        }

                                        };   
			});
                }
		function getFormSubmissions()
		{
			$(document).ready(function () { // Populate submissionList
                                var form = document.getElementById("form");
                                var activeform = document.getElementById("formSelect");
                                var value = activeform.options[activeform.selectedIndex].value;
				var submissionList = document.getElementById('submissionSelect');
				var formData = new FormData(form);
                                submissionList.options.length = 0;
                                var response;
                                formData.append("unique_url", value);
                                        var xhr = new XMLHttpRequest();       

                                        xhr.open("POST","formview", true);

                                        xhr.send(formData);

                                        xhr.onload = function(e) {

                                            if (this.status == 200) {
                                                console.log(this.responseText);
                                               response = this.responseText;
                                               var submissions = JSON.parse(response);
                                               //getSubmission(response);
                                               submissions.forEach(myFunction); 
                                                function myFunction(item) 
                                                { 
                                                    submissionList.options[submissionList.options.length] = new Option(item);
                                                    
                                            }
                                            console.log(submissionList.options.value);
                                            console.log("length " + document.getElementById('submissionSelect').length);
                                            
                                            getFormSubmission();
                                            document.getElementById("deleteform").disabled = false;
                                        }

                                        };   
				console.log("clickity clackity");
				var i;
			});
		}
		function getSubmission(formdata)
		{
                        var FormData = formdata;
                        //var container = document.getElementById('form1');
			// Render form submission
			jQuery(function($)
			{
                            $('.form1').formRender({
					dataType: 'json',
					formData: FormData
                                        
				});
			});
                        //var form = document.getElementById("form1");
                        $("#form1 :input").prop("disabled", true);
                        console.log(form1);
                        document.getElementById("deletesub").disabled = false;

                       // var elements = form.elements;
                       // for (var i = 0, len = elements.length; i < len; ++i) {
                        //     elements[i].readOnly = true;
                        //}
		}
                

                
                                        function getFormSubmission() {
                                        
                                        console.log("bloop");
                                        
                                        var form = document.getElementById("form");
                                        var activeform = document.getElementById("formSelect");
                                        if (activeform.options.length !== 0)
                                            var value = activeform.options[activeform.selectedIndex].value;
                                        var activesub = document.getElementById("submissionSelect");
                                        if (activesub.options.length !== 0)
                                            var sub = activesub.options[activesub.selectedIndex].value;
                                        var formData = new FormData(form);
                                        console.log("form: "+ value + " sub: " + sub);
                                        formData.append("unique_url", value);
                                        formData.append("ObjectId", sub);
                                        var xhr = new XMLHttpRequest();       

                                        xhr.open("POST","subview", true);

                                        xhr.send(formData);

                                        xhr.onload = function(e) {

                                            if (this.status == 200) {
                                                console.log(this.responseText)
                                                if(activesub.options.length === 0)
                                                {
                                                    getSubmission([{"type":"header","subtype":"h1","label":"There Are No Form Submissions"}]);
                                                }
                                                else
                                                {
                                                getSubmission(this.responseText);
                                                }
                                            }

                                        };   
                                        
                

    } 
    
        function deletecurrentsubmission() {
            console.log("bloop");
                                        var form = document.getElementById("form");
                                        var activeform = document.getElementById("formSelect");
                                        var value = activeform.options[activeform.selectedIndex].value;
                                        var activesub = document.getElementById("submissionSelect");
                                        var sub = activesub.options[activesub.selectedIndex].value;
                                        var formData = new FormData(form);
                                        console.log("form: "+ value + " sub: " + sub);
                                        formData.append("unique_url", value);
                                        formData.append("ObjectId", sub);
                                        var xhr = new XMLHttpRequest();       

                                        xhr.open("POST","delete", true);

                                        xhr.send(formData);

                                        xhr.onload = function(e) {

                                            if (this.status == 200) {
                                                console.log(this.responseText)
                                                getFormSubmissions();

                                            }

                                        };   
        }
        
        function deletecurrentform() {
            console.log("bloop");
                                        var form = document.getElementById("form");
                                        var activeform = document.getElementById("formSelect");
                                        var deletevalue = "delete";
                                        var value = activeform.options[activeform.selectedIndex].value;
                                        console.log("bloop " + activeform.options[activeform.selectedIndex].value);
                                        var formData = new FormData(form);
                                        formData.append("unique_url", value);
                                        var xhr = new XMLHttpRequest();       

                                        xhr.open("POST","delete", true);

                                        xhr.send(formData);

                                        xhr.onload = function(e) {

                                            if (this.status == 200) {
                                                getFormSubmissions();
                                                getForms();
                                            }

                                        };   
        }
		// Note - checkbox selections, when field required, do not render; issue with formBuilder https://github.com/kevinchappell/formBuilder/issues/910
	</script>
</body>
</html>