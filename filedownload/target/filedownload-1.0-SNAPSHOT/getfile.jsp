<%-- 
    Document   : getfile
    Created on : Nov 26, 2019, 4:04:04 PM
    Author     : Steve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        

  <div style="text-align: center;">
    <h1>Test for embeded PDF on a webpage</h1>

    <iframe src= <% String s = request.getAttribute("filepath").toString() ; %> style= width:100%; height:100%; frameborder="0">
    </iframe>

  </div>
    </body>
</html>
