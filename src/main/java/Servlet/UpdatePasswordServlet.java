import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdatePasswordServlet", urlPatterns = {"/update-password"})
public class UpdatePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Hứng dữ liệu từ form reset-password.jsp gửi lên
        String email = request.getParameter("email");
        String token = request.getParameter("token"); 
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 2. Kiểm tra xem 2 ô nhập mật khẩu có giống nhau không
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match. Please try again!");
            request.getRequestDispatcher("/web/reset-password.jsp").forward(request, response);
            return; // Dừng lại, không chạy code bên dưới nữa
        }

        // =======================================================
        // =======================================================
        // =======================================================
        // 3. CODE JPA CẬP NHẬT DATABASE
        // =======================================================
        boolean isUpdated = false;
        
        // TODO: Thay "TEN_PU_CUA_BAN" bằng tên trong file persistence.xml
        jakarta.persistence.EntityManagerFactory emf = jakarta.persistence.Persistence.createEntityManagerFactory("EnergyPU");
        jakarta.persistence.EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            // Đã cập nhật thành Users và passwordHash chuẩn theo ảnh bạn gửi
            jakarta.persistence.Query query = em.createQuery("UPDATE Users u SET u.passwordHash = :newPass WHERE u.email = :email");
            
            // Truyền dữ liệu thật vào
            query.setParameter("newPass", newPassword); 
            query.setParameter("email", email);

            int rowsUpdated = query.executeUpdate();
            em.getTransaction().commit();

            if (rowsUpdated > 0) {
                isUpdated = true;
            }
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
        // 4. Xử lý kết quả trả về giao diện
        if (isUpdated) {
            // Nếu đổi mk thành công, báo dòng chữ xanh và cho về trang Login
            request.setAttribute("message", "Password updated successfully! You can now login.");
            request.getRequestDispatcher("/web/login.jsp").forward(request, response);
        } else {
            // Nếu có lỗi lúc lưu Database
            request.setAttribute("error", "Failed to update password in database.");
            request.getRequestDispatcher("/web/reset-password.jsp").forward(request, response);
        }
    }
}