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

        // 👇 THÊM Ở ĐÂY
        user.setUserType("USER");
        user.setCreatedAt(new java.util.Date());

        service.createUser(user);

        System.out.println("REGISTER SUCCESS");

        response.sendRedirect(request.getContextPath() + "/web/login.jsp");

    } catch (Exception e) {

        e.printStackTrace();
        response.setContentType("text/plain");
        e.printStackTrace(response.getWriter());

    }
}
}