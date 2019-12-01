package controllers;
 
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet(description = "List The Already Uploaded Files", urlPatterns = { "/uploadedFilesServlet" })
public class FileViewController extends HttpServlet {
 
    private static final long serialVersionUID = 1L;
    public static final String UPLOAD_DIR = "upload";
 
    /***** This Method Is Called By The Servlet Container To Process A 'GET' Request *****/
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /***** Get The Absolute Path Of The Web Application *****/
        String applicationPath = getServletContext().getRealPath(""),
                uploadPath = applicationPath + File.separator + UPLOAD_DIR + File.separator + "oIDcT" + File.separator + "5de0b0898b4b0939018e144d";
 
        File fileUploadDirectory = new File(uploadPath);
        if (!fileUploadDirectory.exists()) {
            fileUploadDirectory.mkdirs();
        } 
 
        UploadDetail details = null;
        File[] allFiles = fileUploadDirectory.listFiles();
        List<UploadDetail> fileList = new ArrayList<>();        
 
        for (File file : allFiles) {
            details = new UploadDetail();
            details.setFileName(file.getName());
            details.setFileSize(file.length() / 1024);
            fileList.add(details);
        }
 
        request.setAttribute("uploadedFiles", fileList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/allfiles.jsp");
        dispatcher.forward(request, response);
    }
}
