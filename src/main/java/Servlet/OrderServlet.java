package Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Users;
import email.EmailService;

import java.time.LocalDate;

import model.ServicePackages;
import model.Suppliers;

import Service.PackagesService;
import Service.SuppliersService;
import Service.OrdersService;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    private OrdersService service;

    @Override
    public void init() {
        service = new OrdersService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/web/oders/oders.jsp")
                .forward(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        int packageId = Integer.parseInt(request.getParameter("packageId"));

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        OrdersService ordersService = new OrdersService();
        ordersService.createOrder(user.getUserId(), packageId);

        // ===== LẤY THÔNG TIN PACKAGE =====
        PackagesService packageService = new PackagesService();
        ServicePackages servicePackage = packageService.getPackage(packageId);

        // ===== LẤY SUPPLIER =====
        SuppliersService supplierService = new SuppliersService();
        Suppliers supplier = servicePackage.getSupplierId();

        // ===== TÍNH HẠN THANH TOÁN =====
        LocalDate dueDate = LocalDate.now().plusDays(30);

        // ===== GỬI EMAIL =====
        EmailService emailService = new EmailService();

        emailService.sendOrderEmail(
                user.getEmail(),
                user.getName(),
                supplier.getName(),
                servicePackage.getName(),
                servicePackage.getPrice().toString(),
                dueDate.toString()
        );

        session.setAttribute("successMessage",
                "Cảm ơn đã chọn gói dịch vụ. Vui lòng thanh toán trong 30 ngày.");

        response.sendRedirect(request.getContextPath() + "/home");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(500);
    }
}
}
