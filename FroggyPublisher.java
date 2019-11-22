package controllers;

import java.io.IOException;
import java.lang.StringBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mongo.DatabaseController;

public class FroggyPublisher extends HttpServlet {

    public FroggyPubllisher()
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
      boolean isUnique = false;
      while(isUnique == false)
      {
        StringBuilder uniqueBoi = new StringBuilder();
        for(int i = 0; i < 5; i++)
        {
            uniqueBoi.append(randomChar());
        }

        url = uniqueBoi.toString();
        // TODO Check if the url is unique, if yes, set isUnique to true
        isUnique = true;
      }

      return url;
    }

        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    DatabaseController db = new DatabaseController();
		String json = request.getParameter("jsonString");

		if(!json.isEmpty())
		{
      // TODO send json to the database w/ the uniqueURL
      String url = createUniqueURL();

      db.connect();
      db.addForm(url, json);
      db.close();
		}
	}

}
