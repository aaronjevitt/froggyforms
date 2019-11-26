package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mongo.DatabaseController;

public class SubmissionController extends HttpServlet {
 
    public SubmissionController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            DatabaseController db = new DatabaseController();
            String pathinfo = request.getPathInfo();
            pathinfo = pathinfo.substring(1);
            System.out.println(pathinfo);
            db.connect();
            request.setAttribute("formdata", db.getFormJson(pathinfo));
                    
            //RequestDispatcher req = request.getRequestDispatcher("newFormRender.jsp");
            RequestDispatcher req = getServletContext().getRequestDispatcher("/newFormRender.jsp");
            req.forward(request, response);
            db.close();
            
	}
 
}
