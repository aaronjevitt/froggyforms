package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SubmissionController extends HttpServlet {
 
    public SubmissionController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String submit = request.getParameter("submit-form");
		//String view = request.getParameter("view");
                //String delete = request.getParameter("delete");
		
		if(submit != null)
		{
                    System.out.println("Button click recognized");
                    //RequestDispatcher req = request.getRequestDispatcher("formBuilder.jsp");
                    //req.include(request, response);
		}
	}
 
}
