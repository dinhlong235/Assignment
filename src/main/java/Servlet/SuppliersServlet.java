/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Servlet;

/**
 *
 * @author ASUS
 */
import Service.SuppliersService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import model.Suppliers;

@WebServlet(name = "SuppliersServlet", urlPatterns = "/suppliers")
public class SuppliersServlet extends HttpServlet {

    private SuppliersService suppliersService;

    @Override
    public void init() {
        suppliersService = new SuppliersService();
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
                    deleteSupplier(request, response);
                    break;

                default:
                    listSuppliers(request, response);
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

            if ("create".equals(action)) {

                insertSupplier(request, response);

            } else if ("edit".equals(action)) {

                updateSupplier(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // LIST
    private void listSuppliers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Suppliers> list = suppliersService.getAllSuppliers();

        request.setAttribute("listSuppliers", list);

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("suppliers/supplierList.jsp");

        dispatcher.forward(request, response);
    }

    // SHOW CREATE FORM
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("suppliers/createSupplier.jsp");

        dispatcher.forward(request, response);
    }

    // SHOW EDIT FORM
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        Suppliers supplier = suppliersService.getSupplier(id);

        request.setAttribute("supplier", supplier);

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("suppliers/editSupplier.jsp");

        dispatcher.forward(request, response);
    }

    // INSERT
    private void insertSupplier(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String contactInfo = request.getParameter("contactInfo");

        Suppliers supplier = new Suppliers();

        supplier.setName(name);
        supplier.setType(type);
        supplier.setContactInfo(contactInfo);

        suppliersService.createSupplier(supplier);

        response.sendRedirect("suppliers");
    }

    // UPDATE
    private void updateSupplier(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("supplierId"));

        Suppliers supplier = suppliersService.getSupplier(id);

        supplier.setName(request.getParameter("name"));
        supplier.setType(request.getParameter("type"));
        supplier.setContactInfo(request.getParameter("contactInfo"));

        suppliersService.updateSupplier(supplier);

        response.sendRedirect("suppliers");
    }

    // DELETE
    private void deleteSupplier(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("supplierId"));

        suppliersService.deleteSupplier(id);

        response.sendRedirect("suppliers");
    }
}