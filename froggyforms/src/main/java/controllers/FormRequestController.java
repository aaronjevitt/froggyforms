package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mongo.DatabaseController;

public class FormRequestController extends HttpServlet {
 
    public FormRequestController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
        @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            DatabaseController db = new DatabaseController();
            String pathinfo = request.getPathInfo();
            String formjson;
            pathinfo = pathinfo.substring(1);
            System.out.println(pathinfo);
            db.connect();
            request.setAttribute("uniqurl", pathinfo);
            formjson = db.getFormJson(pathinfo);
            
            request.setAttribute("formdata", db.getFormJson(pathinfo));
            RequestDispatcher req;
            if(formjson == null)
                req = getServletContext().getRequestDispatcher("/FormDNE.jsp");              
            else
                req = getServletContext().getRequestDispatcher("/formRender.jsp");
            req.include(request, response);
            db.close();
            
	}
 
}
