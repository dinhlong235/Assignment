package Servlet;

import Service.UsersService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import model.Users;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    UsersService service = new UsersService();

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Users user = service.login(username, password);

        if(user != null){

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if("ADMIN".equals(user.getUserType())){

                response.sendRedirect(request.getContextPath() + "/web/admin.jsp");

            } else {

                response.sendRedirect(request.getContextPath() + "/web/home.jsp");  

            }

        } else {

            request.setAttribute("error", "Sai username hoặc password");
            request.getRequestDispatcher("/web/login.jsp")
                   .forward(request, response);

        }
    }
}