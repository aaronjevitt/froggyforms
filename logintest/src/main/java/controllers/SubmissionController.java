package controllers;

import static constants.Constants.UPLOAD_DIRECTORY;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import mongo.DatabaseController;
import org.bson.types.ObjectId;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
  maxFileSize = 1024 * 1024 * 5, 
  maxRequestSize = 1024 * 1024 * 5 * 5)
public class SubmissionController extends HttpServlet
{
    
    private static final long serialVersionUID = 1L;

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename"))
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
        }
        return constants.Constants.DEFAULT_FILENAME;
    }
    
public void doPost(HttpServletRequest request,HttpServletResponse response)
throws IOException, ServletException
{
    ObjectId objectid;
    DatabaseController db = new DatabaseController();
    String url;
    String formdata;
    String uploadPath;
    db.connect();
    
    url = request.getParameter("unique_url");   
    formdata = request.getParameter("formjson");      
    objectid = db.addSubmission(url, formdata);
    
    PrintWriter out = response.getWriter();   
    out.println(url + " " + formdata);
    
    uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY + File.separator + url + File.separator + objectid.toString();
    File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdir();
        try {
            String fileName = "";
            for (Part part : request.getParts()) {
                fileName = getFileName(part);
                if (!"default.file".equals(fileName))
                    part.write(uploadPath + File.separator + fileName);
            }
            request.setAttribute("message", "File " + fileName + " has uploaded successfully!");
        } catch (FileNotFoundException fne) {
            request.setAttribute("message", "There was an error: " + fne.getMessage());
        }
        //getServletContext().getRequestDispatcher("/result.jsp").forward(request, response);
}
}