<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name=?viewport? content=?width=device-width, initial-scale=1?>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" charset="utf-8">
<title>View Submitted Forms</title>
</head>
<body>
<form id="form">

<h4>Forms</h4>
<select class="form-control"  id='formSelect' name='formSelect' onClick="getFormSubmissions()"></select>
<label for="formnum">Form URL:</label>
<textarea id="formnum" rows="1" cols="6" readonly="true"></textarea>
<h4>Submission:</h4>
<select class="form-control"  id='submissionSelect' name='submissionSelect' onClick="getFormSubmission()"></select>
<label for="subnum">Submission ID:</label>

<textarea id="subnum" rows="1" cols="23" readonly="true"></textarea>


<button type="button" class="form-control" id='deletesub' name='deletesub' onClick='deletecurrentsubmission()' disabled='true'>Delete Submission</button>
<button type="button" class="form-control" id='deleteform' name='deleteform' onClick='deletecurrentform()' disabled='true'>Delete Form</button>
</form>

<div class="form1" id = "form1">
</div>
    
<h4>View Files From Submission</h4>
<select class="form-control"  id='viewFiles' name='viewFiles' onClick="viewFiles()"></select>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<script src="https://formbuilder.online/assets/js/form-render.min.js"></script>
<script>
    getForms();
    var submissionMap;
    var formMap;
    
    function getForms()
    {
        var form = document.getElementById("form");
        var formList = document.getElementById("formSelect");
        var submissionList = document.getElementById('submissionSelect');
        var formData = new FormData(form);
        var xhr = new XMLHttpRequest(); 
        formMap = new Map();
        submissionList.options.length = 0;
        formList.options.length=0;
        xhr.open("POST","formlist", true);
        xhr.send(formData);
        xhr.onload = function(e) 
        {
            if (this.status === 200) 
            {
                var forms = JSON.parse(this.responseText);
                var i = 1;
                forms.forEach(myFunction); 
                function myFunction(item) 
                { 
                    
                    formMap.set("Form " + i, item);
                    formList.options[formList.options.length] = new Option("Form " + i++);
                }
                if(formList.options.length !== 0)
                {
                    getFormSubmissions();
                    
                }
                    
            }
        };   
    }
    
    function getFormSubmissions()
    {
        var form = document.getElementById("form");
        var activeform = document.getElementById("formSelect");
        var value = formMap.get(activeform.options[activeform.selectedIndex].value);
        var submissionList = document.getElementById('submissionSelect');
        var formData = new FormData(form);
        document.getElementById("formnum").value = value;
        submissionList.options.length = 0;
        submissionMap = new Map();
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
                var i = 1;

                submissions.forEach(myFunction); 
                function myFunction(item) 
                { 
                    submissionMap.set("Submission " + i,item);
                    submissionList.options[submissionList.options.length] = new Option("Submission " + i++);
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
        formData.append("unique_url", formMap.get(value));
        formData.append("ObjectId", submissionMap.get(sub));
        var xhr = new XMLHttpRequest();       
        xhr.open("POST","subview", true);
        xhr.send(formData);
        xhr.onload = function(e) 
        {
            if (this.status == 200) 
            {
                if(activesub.options.length === 0)
                    getSubmission([{"type":"header","subtype":"h1","label":"There Are No Form Submissions"}]);
                else
<<<<<<< Updated upstream
=======
                {
                    console.log(sub);
                    document.getElementById("subnum").value = submissionMap.get(sub);
>>>>>>> Stashed changes
                    getSubmission(this.responseText);
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
    
    
		// Note - checkbox selections, when field required, do not render; issue with formBuilder https://github.com/kevinchappell/formBuilder/issues/910
	</script>
</body>
</html>