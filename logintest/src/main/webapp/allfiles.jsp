<%@page import="controllers.UploadDetail"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Servlet File Upload/Download</title>
         
    </head>
    <body>
        <div class="panel">
            <h1>Uploaded Files</h1>
            <table class="bordered_table">
               <thead>
                  <tr align="center"><th>File Name</th><th>File Size</th><th>Download</th><th>Preview</th></tr>
               </thead>
               <tbody>
                  <% List<UploadDetail> uploadDetails = (List<UploadDetail>)request.getAttribute("uploadedFiles");
                     if(uploadDetails != null && uploadDetails.size() > 0) {
                     for(int i=0; i<uploadDetails.size(); i++) {
                  %>
                  <tr>
                     <td align="center"><span id="fileName"><%=uploadDetails.get(i).getFileName() %></span></td>
                     <td align="center"><span id="fileSize"><%=uploadDetails.get(i).getFileSize() %> KB</span></td>
                     <td align="center"><span id="fileDownload"><a href='downloadfile?fileName=<%=uploadDetails.get(i).getFileName()%>&url=<%=request.getParameter("url") %>&objid=<%=request.getParameter("objid") %>'>Download</button></span></td>
                     <td align="center"><span id="filePreview"><a href='https://docs.google.com/gview?url=http://froggyforms.ddns.net:8080/upload/<%=request.getParameter("url")%>/<%=request.getParameter("objid") %>/<%=uploadDetails.get(i).getFileName()%>' target="_blank">Preview</button></span></td>
                     
                  </tr>
                  <% }
                   } else { %>
                  <tr>
                     <td colspan="3" align="center"><span id="noFiles">No Files Uploaded.....!</span></td>
                  </tr>
                  <% } %>
               </tbody>
            </table>
               <form id="form">
               </form>
            <div class="margin_top_15px">
               <a id="fileUpload" class="hyperLink" href="<%=request.getContextPath()%>/FormView.jsp">Back</a>
            </div>
         </div>
    </body>
</html>