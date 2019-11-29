package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mongo.DatabaseController;

@MultipartConfig
public class SubViewController extends HttpServlet {
 
    public SubViewController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            DatabaseController db = new DatabaseController();
            //String pathinfo = request.getPathInfo();
            String submission_json;
            PrintWriter out = response.getWriter();  
            //pathinfo = pathinfo.substring(1);
            //System.out.println(pathinfo);
            db.connect();
            System.out.println(request.getParameter("ObjectId"));
            System.out.println(request.getParameter("unique_url"));
            if(request.getParameter("ObjectId").compareTo("undefined") == 0)
            {
                out.println("oof");
                return;
            }
            //submission_json = db.getSubmissionJson(pathinfo, request.getParameter("ObjectId"));
            if(request.getParameter("ObjectId") == null || request.getParameter("unique_url") == null)
            {
                out.println("[]");

                return;
            }
            submission_json = db.getSubmissionJson(request.getParameter("unique_url"), request.getParameter("ObjectId"));
            out.println(submission_json);
            request.setAttribute("submission_json", submission_json);
            System.out.println(submission_json);
             
    
            //request.setAttribute("formdata", db.getFormJson(pathinfo));
            //RequestDispatcher req = request.getRequestDispatcher("FormView.jsp");
            //req.include(request, response);
            db.close();
            
	}
 
}
