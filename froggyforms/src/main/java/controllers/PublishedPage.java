/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mongo.DatabaseController;

public class PublishedPage extends HttpServlet {
    
    public PublishedPage() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
        {
            DatabaseController db = new DatabaseController();
            String url;
            
            db.connect();
            url = db.getLastForm();
            
            //request.setAttribute("unique_url", url);
            System.out.println("got form " + url);
            
            db.close();
            System.out.println("this is the get request speaking");
            
            HttpSession session = request.getSession();
            session.setAttribute("unique_url", url);
        }
        
        protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
        { 
            System.out.println("huckus in my tuckus");
        }
        
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
        {
            String home = request.getParameter("homepage");
            
            if(home != null)
            {
                RequestDispatcher req = request.getRequestDispatcher("homepage.jsp");
                req.include(request, response);
            }
        }
}
