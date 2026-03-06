package Servlet;

import Service.OrdersService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Orders;
import model.Users;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {

    private OrdersService ordersService;

    @Override
    public void init() {
        ordersService = new OrdersService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/web/login.jsp");
            return;
        }

        Users user = (Users) session.getAttribute("user");

        Orders pendingOrder
                = ordersService.findOrderByUserAndStatus(user.getUserId(), "pending");

        Orders activeOrder
                = ordersService.findOrderByUserAndStatus(user.getUserId(), "active");

        request.setAttribute("pendingOrder", pendingOrder);
        request.setAttribute("activeOrder", activeOrder);

        request.getRequestDispatcher("/web/account.jsp")
                .forward(request, response);
    }
}
