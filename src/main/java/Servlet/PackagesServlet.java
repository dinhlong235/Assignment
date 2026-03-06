package Servlet;

import Service.PackagesService;
import Service.UsersService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import model.ServicePackages;

import model.Users;

@WebServlet("/packages")
public class PackagesServlet extends HttpServlet {

    private PackagesService service;

    @Override
    public void init() {
        service = new PackagesService();
    }

    // ========================= GET =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deletePackage(request, response);
                    break;
                default:
                    listPackages(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // ========================= POST =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertPackage(request, response);
                    break;
                case "update":
                    updatePackage(request, response);
                    break;
                default:
                    response.sendRedirect("packages");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // ========================= LIST =========================
    private void listPackages(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List<ServicePackages> list = service.getAllPackages();
        request.setAttribute("listPackages", list);
        request.getRequestDispatcher("/web/packages/packageList.jsp")
                .forward(request, response);
    }

    // ========================= CREATE FORM =========================
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        request.getRequestDispatcher("/web/packages/createPackage.jsp")
                .forward(request, response);
    }

    // ========================= EDIT FORM =========================
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        ServicePackages pkg = service.getPackage(id);

        request.setAttribute("pkg", pkg);
        request.getRequestDispatcher("/web/packages/editPackage.jsp")
                .forward(request, response);
    }

    // ========================= INSERT =========================
    private void insertPackage(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        ServicePackages pkg = new ServicePackages();
        pkg.setName(request.getParameter("name"));
        pkg.setPrice(new java.math.BigDecimal(request.getParameter("price")));
        pkg.setPackageType(request.getParameter("packageType"));
        pkg.setDescription(request.getParameter("description"));

        service.createPackage(pkg);

        response.sendRedirect("packages");
    }

    // ========================= UPDATE =========================
    private void updatePackage(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        ServicePackages pkg = service.getPackage(id); // lấy từ DB

        pkg.setName(request.getParameter("name"));
        pkg.setPrice(new java.math.BigDecimal(request.getParameter("price")));
        pkg.setPackageType(request.getParameter("packageType"));
        pkg.setDescription(request.getParameter("description"));

        service.updatePackage(pkg);

        response.sendRedirect(request.getContextPath() + "/packages");
    }

    // ========================= DELETE =========================
    private void deletePackage(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        service.deletePackage(id);

        response.sendRedirect("packages");
    }
}
