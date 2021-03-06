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
public class FormListController extends HttpServlet {
 
    public FormListController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            DatabaseController db = new DatabaseController();
            db.connect();
            ArrayList<String> forms;
            forms = db.getAllFormURLS();
            PrintWriter out = response.getWriter();   
            out.println(forms.toString());
    
            //request.setAttribute("formdata", db.getFormJson(pathinfo));
            //RequestDispatcher req = request.getRequestDispatcher("FormView.jsp");
            //req.include(request, response);
            db.close();
            
	}
 
}
