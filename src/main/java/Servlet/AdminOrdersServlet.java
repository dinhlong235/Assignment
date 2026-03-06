/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Service.OrdersService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Orders;
import model.Payments;

@WebServlet("/orders")
public class AdminOrdersServlet extends HttpServlet {

    private OrdersService service;

    @Override
    public void init() {
        service = new OrdersService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String status = request.getParameter("status");

        try {

            if ("approve".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                service.approveOrder(id);
                response.sendRedirect("orders");
                return;
            }

            if ("cancel".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                service.cancelOrder(id);
                response.sendRedirect("orders");
                return;
            }

            if ("view".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                Orders order = service.getOrder(id);
                List<Payments> payments = service.getPaymentsByOrder(id);

                request.setAttribute("order", order);
                request.setAttribute("payments", payments);

                request.getRequestDispatcher("/web/admin/orderDetail.jsp")
                        .forward(request, response);
                return;
            }

            List<Orders> list;

            if (status != null && !status.isEmpty()) {
                list = service.getOrdersByStatus(status);
            } else {
                list = service.getAllOrders();
            }

            request.setAttribute("listOrders", list);
            request.getRequestDispatcher("/web/admin/orderList.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
