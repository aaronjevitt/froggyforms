/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.filedownload;


import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Steve
 */

public class filedownloadser extends HttpServlet 
{
    
    public String finder(String URL)
    {
        // remove this when you swithc it aaron
        String GIT = System.getProperty("user.dir");
        
        String filepath = GIT + "/download/" + URL + "/q.JPG";
        System.out.println(filepath);
        System.out.println(URL);
        return filepath;
    }
            @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        String URL = "qwer";
        System.out.println("11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
        // reads input file from an absolute path

        String filePath = finder(URL);
        request.setAttribute("filepath", filePath);
        RequestDispatcher rd = request.getRequestDispatcher("getfile.jsp"); 
        
        File downloadFile = new File(filePath);
        OutputStream outStream;
        // if you want to use a relative path to context root:
        try (FileInputStream inStream = new FileInputStream(downloadFile)) {
            // if you want to use a relative path to context root:
            String relativePath = getServletContext().getRealPath("");
            System.out.println("relativePath = " + relativePath);
            // obtains ServletContext
            ServletContext context = getServletContext();
            // gets MIME type of the file
            String mimeType = context.getMimeType(filePath);
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }   System.out.println("MIME type: " + mimeType);
            // modifies response
            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());
            // forces download
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
            response.setHeader(headerKey, headerValue);
            // obtains response's output stream
            outStream = response.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
        }
        outStream.close();		
    }
}
