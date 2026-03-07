import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID; // Thêm thư viện này để tạo Token

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        boolean isExist = true; // Vẫn đang giả vờ là email hợp lệ
        
        if (isExist) {
            // 1. Tạo một Token ngẫu nhiên (Rất dài và không thể đoán được)
            String token = UUID.randomUUID().toString();
            
            // 2. Tạo đường link Reset Password chứa Email và Token
            // Cấu trúc: http://localhost:8080/Energy_backend/web/reset-password.jsp?email=...&token=...
            String resetLink = request.getScheme() + "://" + request.getServerName() 
                             + ":" + request.getServerPort() + request.getContextPath() 
                             + "/web/reset-password.jsp?email=" + email + "&token=" + token;
            
            // 3. Gửi email chứa đường link đó
            boolean isSent = EmailUtility.sendEmail(email, resetLink);
            
            if (isSent) {
                request.setAttribute("message", "A reset link has been sent to your email!");
                request.getRequestDispatcher("/web/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to send email. Please try again.");
                request.getRequestDispatcher("/web/forgot-password.jsp").forward(request, response);
            }
        }
        // ... (Phần báo lỗi email không tồn tại giữ nguyên) ...
    }
}