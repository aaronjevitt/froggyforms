import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FroggyLogin extends HttpServlet {
 
    public FroggyLogin() {
        super();
        // TODO Auto-generated constructor stub
    }
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(username.isEmpty() || password.isEmpty() )
		{
			RequestDispatcher req = request.getRequestDispatcher("login_logout.jsp");
			req.include(request, response);
		}
		else if(username.compareToIgnoreCase("admin") == 0 && password.compareTo("password") == 0)
		{
			RequestDispatcher req = request.getRequestDispatcher("login_success.jsp");
			req.forward(request, response);
		}
		else
		{
			RequestDispatcher req = request.getRequestDispatcher("login_fail.jsp");
			req.include(request, response);
		}
	}
 
}
