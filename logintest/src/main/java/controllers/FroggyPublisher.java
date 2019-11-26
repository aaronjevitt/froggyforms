package controllers;

import java.io.IOException;
import java.lang.StringBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mongo.DatabaseController;

public class FroggyPublisher extends HttpServlet {

    public FroggyPublisher()
    {
        super();
    }

    public static char randomChar()
    {
      int rand = (int)(Math.random() * 62);
      if(rand >= 0 && rand <= 9)
      {
        return (char)('0' + rand);
      }
      else if(rand >= 10 && rand <= 35)
      {
        return (char)('a' + (rand - 10));
      }
      else
      {
        return (char)('A' + (rand - 36));
      }
    }

    public static String createUniqueURL()
    {
      String url = new String();
      DatabaseController db = new DatabaseController();
      boolean isUnique = false;

      while(isUnique == false)
      {
        StringBuilder uniqueBoi = new StringBuilder();
        for(int i = 0; i < 5; i++)
        {
            uniqueBoi.append(randomChar());
        }
        url = uniqueBoi.toString();

        db.connect();
        if(!db.checkIfExists(url))
        	isUnique = true;

        db.close();
      }

      return url;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        DatabaseController db = new DatabaseController();
        String json = request.getParameter("jsonString");
        String url = new String();
        
        System.out.println("string reps: ");
        System.out.println(request.getPathInfo());
        System.out.println(response.toString());

        if(json != null && !json.isEmpty())
        {
            url = createUniqueURL();

            db.connect();
            db.addNewForm(url, json);
            db.close();
        }
        else
        {
            System.out.println("No form");
        }
        
//            db = new DatabaseController();
//            //String url;
//            
//            db.connect();
//            url = db.getLastForm();
//            
//            //request.setAttribute("unique_url", url);
//            System.out.println("got form " + url);
//            
//            db.close();
        
        RequestDispatcher req = request.getRequestDispatcher("FroggyFormPublished.jsp");
        System.out.println("post request froggypublisher");
        
        HttpSession session = request.getSession();
        session.setAttribute("unique_url", "The URL for this form is froggyform.bike/" + url);
        
        req.include(request, response);
        
        return;
    }
}
