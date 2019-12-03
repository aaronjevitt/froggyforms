<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name=?viewport? content=?width=device-width, initial-scale=1?>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>FroggyForm Home</title>
<style>
table, th, td {
  border: 1px solid green;
}
body{
  background-image: url("FrogEmoji.jpg");
  background-repeat: round;
}
</style>
</head>
<body>

<form action="AdminPage" method="post">
<div>
  <p style="text-align: center;"><b style ="background-color: white">Welcome to FroggyForm, Admin. What would you like to do?<b></p>
</div>

<table style="width: 100%; height: 80vh; margin-top: 15vh">
  <tr>
    <td><input type="submit" value="Create Form" name="create" style="width: 100%; height: 100%;"/></td>
    <td><input type="submit" value="View Form" name="view" style="width: 100%; height: 100%;"/></td>
    <td><input type="submit" value="Delete Form" name="delete" style="width: 100%; height: 100%;"/></td>
  </tr>
</table>

</body>
</html>
