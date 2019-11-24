package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mongo.DatabaseController;

public class AdminController extends HttpServlet {
 
    public AdminController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String create = request.getParameter("create");
		String view = request.getParameter("view");
                String delete = request.getParameter("delete");
		
		if(create != null)
		{
                    RequestDispatcher req = request.getRequestDispatcher("FormBuilder.jsp");
                    req.include(request, response);
		}
                else if(view != null)
                {
                    DatabaseController db = new DatabaseController();
                    db.connect();
                    System.out.println(db.getLastForm());
                    
                    RequestDispatcher req = request.getRequestDispatcher("dummyview.jsp");
                    db.close();
                    req.include(request, response);
                }
                else if(delete != null)
                {
                    RequestDispatcher req = request.getRequestDispatcher("dummydelete.jsp");
                    req.include(request, response);
                }
	}
 
}
