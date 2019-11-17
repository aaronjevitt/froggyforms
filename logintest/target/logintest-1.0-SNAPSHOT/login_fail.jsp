<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.center {
  margin: auto;
  width: 50%;
}

.buttn {
  margin: auto;
  width: 25%;
}
table, th, td {
  border: 1px solid green;
}
body{
  background-image: url("FrogForming.jpg");
  background-repeat: round;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>FroggyForm Login</title>
</head>
<body>
<form action="FroggyLogin" method="post">

    <h1 style="color: red; width: 60%; background-color: white; margin-top: 10vh; margin-left: 20%; text-align: center;"> The username or password was incorrect. </h1>
		<table style="width: 50%; background-color: white; margin-left: 25%;">
			<tr>
				<td><p style="width: 50%">Username</p></td>
				<td><input type="text" name="username" style="width: 100%"/></td>
			</tr>
			<tr>
				<td><p style="width: 50%">Password</p></td>
				<td><input type="text" name="password" style="width: 100%"/></td>
			</tr>
		</table>

    <div  class="center">
		<input type="submit" value="Log in"  class="buttn"/></form>
    </div>
</body>
</html>
