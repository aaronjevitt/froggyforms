<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form Published!</title>
<script>
      // window.onload = function()
      // {
      //   document.getElementById("msg").innerHTML = "sup";
      //   // var uniqueURL = request.getAttribute("unique_url");
      //   // var message = "The URL to fill out this form is FroggyForm.bike/" + uniqueURL;
      //   console.log("window.onload");
      //   document.getElementById("onload").click();
      // };
      //
      // function realOnLoad(str)
      // {
      //   var message = "The URL to fill out this form is FroggyForm.bike/" + str;
      //   console.log(message);
      //   document.getElementById("msg").innerHTML = message;
      // }
</script>
<style>
body{
  background-color: #d793ff;
}
</style>
</head>

<body>
  <%
    String url = "The URL to fill out this form is froggyforms.ddns.net:8080/f/" + ((String)request.getAttribute("unique_url"));
  %>

  <h1 style="color: green">Form Published!</h1>
  <h2 id="msg" style="color: green">${unique_url}<h2>
  <br></br>
  <form action="PublishedPage" method="post">
    <input type="submit" value="Back to homepage" name="homepage"/>
  </form>

  <!-- <button type = "button" id="onload" onclick="realOnLoad(<%=url %>)" style="visibility: hidden"></button> -->
</body>