package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateController extends HttpServlet {
 
    public CreateController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String create = request.getParameter("publish");
		
		if(create != null)
		{
                    RequestDispatcher req = request.getRequestDispatcher("dummycreate.jsp");
                    req.include(request, response);
		}
	}
 
}
