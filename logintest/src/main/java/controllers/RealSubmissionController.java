package controllers;

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

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
  maxFileSize = 1024 * 1024 * 5, 
  maxRequestSize = 1024 * 1024 * 5 * 5)
public class RealSubmissionController extends HttpServlet
{
    
    private static final long serialVersionUID = 1L;

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename"))
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
        }
        return com.baeldung.Constants.DEFAULT_FILENAME;
    }
    
public void doPost(HttpServletRequest request,HttpServletResponse response)
throws IOException, ServletException
{
PrintWriter out = response.getWriter();
    String formdata = request.getParameter("formjson");

    out.println("urmom"+ formdata);
String uploadPath = getServletContext().getRealPath("") + File.separator + com.baeldung.Constants.UPLOAD_DIRECTORY;
        System.out.println(uploadPath);
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdir();

        try {
            String fileName = "";
            System.out.println("1");
            for (Part part : request.getParts()) {
                fileName = getFileName(part);
                part.write(uploadPath + File.separator + fileName);
            }
            request.setAttribute("message", "File " + fileName + " has uploaded successfully!");
        } catch (FileNotFoundException fne) {
            System.out.println("2");
            request.setAttribute("message", "There was an error: " + fne.getMessage());
        }
        System.out.println("3");
        getServletContext().getRequestDispatcher("/result.jsp").forward(request, response);
        System.out.println("4");
}
}