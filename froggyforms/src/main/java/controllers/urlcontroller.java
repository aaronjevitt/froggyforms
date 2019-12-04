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
public class urlcontroller extends HttpServlet {
 
    public urlcontroller() {
        super();
        // TODO Auto-generated constructor stub
    }
    
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            DatabaseController db = new DatabaseController();
            db.connect();
            System.out.println("checking duplicates " + request.getParameter("unique_url"));
            String url = request.getParameter("unique_url");
            PrintWriter out = response.getWriter();   
            if(db.checkIfExists(url))
            {
                out.print("1");            
            }
            else
            {
                if (url.charAt(0)==' ')
                    out.print("2");
                else
                    out.print("0");
            }
    
	}
 
}