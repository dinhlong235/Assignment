package Servlet;

import Service.UsersService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Users;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UsersService service;

    @Override
    public void init() {
        service = new UsersService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Users user = new Users();
            user.setName(fullname);
            user.setEmail(email);
            user.setPasswordHash(password);

            service.createUser(user);
            System.out.println("REGISTER SUCCESS");
            // redirect tới login page
            response.sendRedirect(request.getContextPath() + "/web/login.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath() + "/web/register.jsp");

        }
    }
}