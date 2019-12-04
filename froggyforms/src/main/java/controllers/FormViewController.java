package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mongo.DatabaseController;
import org.bson.types.ObjectId;


@MultipartConfig
public class FormViewController extends HttpServlet {
 
    public FormViewController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            DatabaseController db = new DatabaseController();
            String responsetext;
            db.connect();
            ArrayList<String> submissions;
            System.out.println(request.getParameter("unique_url"));
            submissions = db.getAllSubmissionID(request.getParameter("unique_url"));
            responsetext = "[ \"";
            for(String sub : submissions)
            {
                responsetext = responsetext + sub + "\", \"";
            }
                responsetext = responsetext.substring(0,responsetext.length()-3);
                responsetext = responsetext + " ]";
            System.out.println(responsetext);
            if (submissions.size() == 0)
                responsetext = "[]";
            
            PrintWriter out = response.getWriter();   
            out.println(responsetext);
    
            //request.setAttribute("formdata", db.getFormJson(pathinfo));
            //RequestDispatcher req = request.getRequestDispatcher("FormView.jsp");
            //req.include(request, response);
            db.close();
            
	}
 
}
