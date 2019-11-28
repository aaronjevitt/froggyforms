package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mongo.DatabaseController;

public class RealSubmissionController extends HttpServlet {
 
    public RealSubmissionController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            DatabaseController db = new DatabaseController();
            
            db.connect();
            db.addSubmission("rjIqY", "json_2");
            db.close();
            System.out.println("context path: \n\t" + request.getPathInfo());
            System.out.println("bloop");
	}
 
}
