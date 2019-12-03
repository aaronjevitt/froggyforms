<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" charset="utf-8">
<title>View Submitted Forms</title>
<style>
    body
    {
        background-image: url("builderFrog.jpg");
        background-repeat: round;
    }
    table
    {
        border: 3px solid darkgreen;
        margin-left: 30vw;
        width: 40%;
        font-family: sans-serif;
        box-shadow: 0px 10px 20px rgba(0,0,0,0.2),
            0px 10px 20px rgba(0,0,0,0.25),
            -12px 20px 20px rgba(0,0,0,0.25),
            0px 15px 20px rgba(0,0,0,0.3);
    }
</style>
</head>
<body>
<div style="text-align: center; align-items: center">
<form id="form">

<h4>Form URL:</h4>
<select class="form-control"  id='formSelect' name='formSelect' onClick="getFormSubmissions()"></select>

<h4>Submission:</h4>
<select class="form-control"  id='submissionSelect' name='submissionSelect' onClick="getFormSubmission()"></select>

</form>
    <br></br>
    <br></br>
    <br></br>
    
<table style="background-color: #d793ff">
    <tr>
        <td>
            <div class="form1" id = "form1">
            </div>
        </td>
    </tr>
</table>
    
    
    <br></br>
    <br></br>
<button type="form-control"  id='viewFiles' name='viewFiles' onClick="viewFiles()" style="color: green">View Files From Submission</button>
<br></br>
<button type="button" class="form-control" id='deletesub' name='deletesub' onClick='deletecurrentsubmission()' disabled='true' style="color: red">Delete Submission</button>
<button type="button" class="form-control" id='deleteform' name='deleteform' onClick='deletecurrentform()' disabled='true' style="color: red">Delete Form</button>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<script src="https://formbuilder.online/assets/js/form-render.min.js"></script>
<script>
    getForms();

    function getForms()
    {
        var form = document.getElementById("form");
        var formList = document.getElementById("formSelect");
        var submissionList = document.getElementById('submissionSelect');
        var formData = new FormData(form);
        var xhr = new XMLHttpRequest(); 
        
        submissionList.options.length = 0;
        formList.options.length=0;
        xhr.open("POST","formlist", true);
        xhr.send(formData);
        xhr.onload = function(e) 
        {
            if (this.status === 200) 
            {
                var forms = JSON.parse(this.responseText);
                forms.forEach(myFunction); 
                function myFunction(item) 
                { 
                    formList.options[formList.options.length] = new Option(item);
                }
                if(formList.options.length !== 0)
                    getFormSubmissions();
            }
        };   
    }
    
    function getFormSubmissions()
    {
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
        xhr.onload = function(e) 
        {
            if (this.status == 200) 
            {
                response = this.responseText;
                var submissions = JSON.parse(response);
                submissions.forEach(myFunction); 
                function myFunction(item) 
                { 
                    submissionList.options[submissionList.options.length] = new Option(item);
                }
                getFormSubmission();
                document.getElementById("deleteform").disabled = false;
            }

        };   
    }
    
    function getSubmission(formdata)
    {
        var FormData = formdata;
        jQuery(function($)
        {
            $('.form1').formRender({
                        dataType: 'json',
                        formData: FormData
                });
        });
        $("#form1 :input").prop("disabled", true);
        document.getElementById("deletesub").disabled = false;
    }
                               
    function getFormSubmission() 
    {
        var form = document.getElementById("form");
        var formSelect = document.getElementById("formSelect");
        if (formSelect.options.length !== 0)
            var value = formSelect.options[formSelect.selectedIndex].value;
        var activesub = document.getElementById("submissionSelect");
        if (activesub.options.length !== 0)
            var sub = activesub.options[activesub.selectedIndex].value;
        var formData = new FormData(form);
        formData.append("unique_url", value);
        formData.append("ObjectId", sub);
        var xhr = new XMLHttpRequest();       
        xhr.open("POST","subview", true);
        xhr.send(formData);
        xhr.onload = function(e) 
        {
            if (this.status == 200) 
            {
                if(activesub.options.length === 0)
                {
                    getSubmission([{"type":"header","subtype":"h1","label":"There Are No Form Submissions"}]);
                    document.getElementById("viewFiles").hidden = true;

                    
                }
                else
                {
                    getSubmission(this.responseText);
                    document.getElementById("viewFiles").hidden = false;

                }
            }
        };   
    } 
    
    function deletecurrentsubmission() 
    {
        var form = document.getElementById("form");
        var activeform = document.getElementById("formSelect");
        var value = activeform.options[activeform.selectedIndex].value;
        var activesub = document.getElementById("submissionSelect");
        var sub = activesub.options[activesub.selectedIndex].value;
        var formData = new FormData(form);
        formData.append("unique_url", value);
        formData.append("ObjectId", sub);
        var xhr = new XMLHttpRequest();       
        xhr.open("POST","deletesub", true);
        xhr.send(formData);
        xhr.onload = function(e) {
            if (this.status == 200) 
                getFormSubmissions();
        };   
    }
        
    function deletecurrentform() 
    {
        var form = document.getElementById("form");
        var forms = document.getElementById("formSelect");
        var value = forms.options[forms.selectedIndex].value;
        var formData = new FormData(form);
        formData.append("unique_url", value);
        var xhr = new XMLHttpRequest();       
        xhr.open("POST","deleteform", true);
        xhr.send(formData);
        xhr.onload = function(e) {
            if (this.status == 200) 
            {
                getForms();
                getFormSubmissions();
            }
        };   
    }
    function viewFiles() 
    {
        var form = document.getElementById("form");
        var activeform = document.getElementById("formSelect");
        var value = activeform.options[activeform.selectedIndex].value;
        var activesub = document.getElementById("submissionSelect");
        var sub = activesub.options[activesub.selectedIndex].value;
        var formData = new FormData(form);
        formData.append("unique_url", value);
        formData.append("ObjectId", sub);
        var xhr = new XMLHttpRequest();       
        xhr.open("POST","getfiles", true);
        xhr.send(formData); 
        xhr.onload = function(e){
            console.log(this.responsetext);
            var locationstring = "getfiles?url="+ value + "&objid=" + sub;
            window.location.assign(locationstring);
        };
    }
    
    
		// Note - checkbox selections, when field required, do not render; issue with formBuilder https://github.com/kevinchappell/formBuilder/issues/910
	</script>
</body>
</html>