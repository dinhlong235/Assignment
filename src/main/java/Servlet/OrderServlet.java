package Servlet;

import Service.OrdersService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Users;

@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet {

    private OrdersService service;

    @Override
    public void init() {
        service = new OrdersService();
    }

    // ================== USER MUA ĐIỆN ==================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");

            // Nếu chưa login → về login
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            int packageId = Integer.parseInt(request.getParameter("packageId"));

            service.createOrder(user.getUserId(), packageId);

            // Thành công → qua success
            response.sendRedirect(request.getContextPath() + "/web/oders/success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            e.printStackTrace(response.getWriter());
        }
    }

    // ================== ADMIN DUYỆT ==================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("approve".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("id"));
                service.approveOrder(orderId);

                response.sendRedirect(request.getContextPath() + "/admin-orders.jsp");

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            response.getWriter().println("Order Servlet Running...");
        }
    }
}