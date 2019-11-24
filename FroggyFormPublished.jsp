<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form Published!</title>
<script>
      function load()
      {
        var uniqueURL = request.getAttribute("unique_url");
        var message = "The URL to fill out this form is FroggyForm.bike/" + uniqueURL;
        console.log(message);
        document.getElementById("msg").innerHTML = message;
      }
      window.onload = load;
    </script>
<style>
body{
  background-color: orange;
}
</style>
</head>

<body>
  <h1 style="color: green">Form Published!</h1>
  <h2 id="msg" style="color: green">The URL to fill out this form is FroggyForm.bike/nonexistantURL<h2>
  <br></br>
  <form action="PublishedPage" method="post">
    <input type="submit" value="Back to homepage" name="homepage"/>
  </form>
</body>
