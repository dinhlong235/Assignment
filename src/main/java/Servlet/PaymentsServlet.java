/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Servlet;

/**
 *
 * @author ASUS
 */
import Service.PaymentsService;
import Service.UsersService;
import Service.OrdersService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import model.Payments;
import model.Users;
import model.Orders;

@WebServlet(name = "PaymentsServlet", urlPatterns = "/payments")
public class PaymentsServlet extends HttpServlet {

    private PaymentsService paymentsService;
    private UsersService usersService;
    private OrdersService ordersService;

    @Override
    public void init() {
        paymentsService = new PaymentsService();
        usersService = new UsersService();
        ordersService = new OrdersService();
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
                    deletePayment(request, response);
                    break;

                default:
                    listPayments(request, response);
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

                insertPayment(request, response);

            } else if ("edit".equals(action)) {

                updatePayment(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // LIST
    private void listPayments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Payments> list = paymentsService.getAllPayments();

        request.setAttribute("listPayments", list);

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("/web/payments/paymentList.jsp");

        dispatcher.forward(request, response);
    }

    // SHOW CREATE FORM
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("usersList", usersService.getAllUsers());
        request.setAttribute("ordersList", ordersService.getAllOrders());

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("/web/payments/createPayment.jsp");

        dispatcher.forward(request, response);
    }

    // SHOW EDIT FORM
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("paymentId"));

        Payments payment = paymentsService.getPayment(id);

        request.setAttribute("payment", payment);
        request.setAttribute("usersList", usersService.getAllUsers());
        request.setAttribute("ordersList", ordersService.getAllOrders());

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("/web/payments/editPayment.jsp");

        dispatcher.forward(request, response);
    }

    // INSERT
    private void insertPayment(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        BigDecimal amount =
                new BigDecimal(request.getParameter("amount"));

        String status =
                request.getParameter("status");

        int userId =
                Integer.parseInt(request.getParameter("userId"));

        int orderId =
                Integer.parseInt(request.getParameter("orderId"));

        Users user =
                usersService.getUser(userId);

        Orders order =
                ordersService.getOrder(orderId);

        Payments payment = new Payments();

        payment.setAmount(amount);
        payment.setStatus(status);
        payment.setPaymentDate(new Date());
        payment.setUserId(user);
        payment.setOrderId(order);

        paymentsService.createPayment(payment);

        response.sendRedirect("payments");
    }

    // UPDATE
    private void updatePayment(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int paymentId =
                Integer.parseInt(request.getParameter("paymentId"));

        BigDecimal amount =
                new BigDecimal(request.getParameter("amount"));

        String status =
                request.getParameter("status");

        int userId =
                Integer.parseInt(request.getParameter("userId"));

        int orderId =
                Integer.parseInt(request.getParameter("orderId"));

        Users user =
                usersService.getUser(userId);

        Orders order =
                ordersService.getOrder(orderId);

        Payments payment =
                paymentsService.getPayment(paymentId);

        payment.setAmount(amount);
        payment.setStatus(status);
        payment.setUserId(user);
        payment.setOrderId(order);

        paymentsService.updatePayment(payment);

        response.sendRedirect("payments");
    }

    // DELETE
    private void deletePayment(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id =
                Integer.parseInt(request.getParameter("paymentId"));

        paymentsService.deletePayment(id);

        response.sendRedirect("payments");
    }
}
