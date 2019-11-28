package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mongo.DatabaseController;
import java.util.Random;

public class FormViewController extends HttpServlet {
 
    public FormViewController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String view2 = request.getParameter("view_form");
                System.out.println("called get request..." + view2);
                String view = (String)request.getSession().getAttribute("view_form");
                Random r = new Random();
                r.setSeed(System.currentTimeMillis());
                
                
                if(view2.compareTo("yes") == 0)
                {
                    //get json of submission
                    //put json into a variable
                    //pass variable to session
                    System.out.println("in view control");
                    HttpSession session = request.getSession();
//                    session.setAttribute("test_att", "\"HELLO\"");
//                    session.removeAttribute("test_att");
//                    session.setAttribute("test_att", Math.random());
//                    session.removeAttribute("test_att");
                    Double splurgealloverme = Math.random();
                    String x = "\"i am testingf\"";
                    session.setAttribute("test_att", x);
                    x = "\"this is a test\"";
                    session.setAttribute("test_att", x);
                    System.out.println(splurgealloverme.toString());
                    
                }
                    
                
                /*else if(view != null)
                {
                    DatabaseController db = new DatabaseController();
                    db.connect();
                    
                    RequestDispatcher req = request.getRequestDispatcher("FormView.jsp");
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("url_array", db.getAllFormURLS());
                    session.setAttribute("num_urls", db.countForms());
                    db.close();
                    
                    req.include(request, response);
                }*/
	}
 
}
