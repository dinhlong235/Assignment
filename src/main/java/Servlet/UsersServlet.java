/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Servlet;

/**
 *
 * @author ASUS
 */
import Service.UsersService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import model.Users;

@WebServlet("/users")
public class UsersServlet extends HttpServlet {

    private UsersService service;

    @Override
    public void init() {
        service = new UsersService();
    }

    // HANDLE GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {

                case "create":
                    showCreateForm(request, response);
                    break;

                case "edit":
                    showEditForm(request, response);
                    break;

                case "delete":
                    deleteUser(request, response);
                    break;

                default:
                    listUsers(request, response);
                    break;
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // HANDLE POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {

            switch (action) {

                case "create":
                    insertUser(request, response);
                    break;

                case "edit":
                    updateUser(request, response);
                    break;
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Users> list = service.getAllUsers();

        request.setAttribute("listUsers", list);

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("users/userList.jsp");

        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("users/createUser.jsp");

        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        Users user = service.getUser(id);

        request.setAttribute("user", user);

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("users/editUser.jsp");

        dispatcher.forward(request, response);
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Users user = new Users();

        user.setName(request.getParameter("username"));
        user.setEmail(request.getParameter("email"));
        user.setPasswordHash(request.getParameter("password"));

        service.createUser(user);

        response.sendRedirect("users");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        Users user = service.getUser(id);

        user.setName(request.getParameter("username"));
        user.setEmail(request.getParameter("email"));
        user.setPasswordHash(request.getParameter("password"));

        service.updateUser(user);

        response.sendRedirect("users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        service.deleteUser(id);

        response.sendRedirect("users");
    }
}
