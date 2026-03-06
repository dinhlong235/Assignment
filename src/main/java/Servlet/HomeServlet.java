package Servlet;

import controller.ServicePackagesJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import model.ServicePackages;
import model.Users;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private EntityManagerFactory emf;
    private ServicePackagesJpaController packageController;

    @Override
    public void init() {
        // Tạo 1 lần duy nhất khi server start
        emf = Persistence.createEntityManagerFactory("EnergyPU");
        packageController = new ServicePackagesJpaController(emf);
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔒 Bảo vệ: chưa login thì quay về login
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users user = (Users) session.getAttribute("user");

        // Lấy filter từ form
        String supplierType = request.getParameter("supplierType");
        String usageType = request.getParameter("usageType");

        List<ServicePackages> list;

        try {
            if (supplierType != null && usageType != null) {
                list = packageController.findPackagesByFilter(supplierType, usageType);
            } else {
                // Nếu chưa chọn filter → hiển thị tất cả
                list = packageController.findServicePackagesEntities();
            }

            request.setAttribute("packages", list);

        } catch (Exception e) {
            request.setAttribute("errorMsg", "Lỗi tải dữ liệu: " + e.getMessage());
        }

        request.getRequestDispatcher("/web/home.jsp")
                .forward(request, response);
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}
