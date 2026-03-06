package Servlet;

import Service.DashboardService;
import Service.UsersService;
import Service.PackagesService;
import Service.OrdersService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import model.Users;

@WebServlet("/admin")
public class DashboardServlet extends HttpServlet {

    private DashboardService dashboardService;
    private UsersService usersService;

    @Override
    public void init() {
        dashboardService = new DashboardService();
        usersService = new UsersService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Long totalUsers = dashboardService.countUsers();
        Long totalPackages = dashboardService.countPackages();
        Long pendingOrders = dashboardService.countPendingOrders();
        Double totalRevenue = dashboardService.totalRevenue();

        List<Users> recentUsers = usersService.getRecentUsers(5);

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalPackages", totalPackages);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("recentUsers", recentUsers);

        request.getRequestDispatcher("/web/admin.jsp")
                .forward(request, response);
    }
    
}
