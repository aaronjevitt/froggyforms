package controllers;
 
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mongo.DatabaseController;
 
public class RealSubmissionController extends HttpServlet {
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*    
        DatabaseController db = new DatabaseController();
            db.connect();
             String pathinfo = request.getPathInfo();
             pathinfo = pathinfo.substring(1);
             System.out.println(pathinfo);
            request.setAttribute("formdata", db.getFormJson(pathinfo));
            
            RequestDispatcher req = getServletContext().getRequestDispatcher("/newFormRender.jsp");
                req.forward(request, response);
            db.close();    
                    //RequestDispatcher req = request.getRequestDispatcher("formBuilder.jsp");
                    //req.include(request, response);
            return;
*/
        System.out.println("bloop");
	}
 
}
