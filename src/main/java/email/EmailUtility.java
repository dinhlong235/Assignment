import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtility {
    // Thay bằng email thật của bạn (dùng để gửi đi)
    private static final String SENDER_EMAIL = "nguyenkhhdan@gmail.com"; 
    // MẬT KHẨU ỨNG DỤNG của Gmail (16 ký tự), KHÔNG phải mật khẩu đăng nhập bình thường
    private static final String SENDER_PASSWORD = "gaxm zaxf klvx qwpi"; 

    public static boolean sendEmail(String toEmail, String resetLink) {
        boolean test = false;

        // Cấu hình thông số SMTP của Google
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        // Đăng nhập vào Gmail
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("VOLTSTREAM - Reset Your Password");
            
            // Cập nhật lại nội dung email: chứa một thẻ <a> để click
            String emailContent = "<h3>Xin chào,</h3>"
                    + "<p>Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản tại VOLTSTREAM.</p>"
                    + "<p>Vui lòng click vào đường link bên dưới để tạo mật khẩu mới:</p>"
                    + "<p><a href=\"" + resetLink + "\" style=\"padding: 10px 15px; background-color: #2563eb; color: white; text-decoration: none; border-radius: 5px; display: inline-block;\">Đặt lại mật khẩu</a></p>"
                    + "<p>Hoặc copy đường dẫn sau dán vào trình duyệt: <br>" + resetLink + "</p>"
                    + "<p>Trân trọng,<br>Đội ngũ VOLTSTREAM</p>";
            
            message.setContent(emailContent, "text/html; charset=UTF-8");

            // Gửi thư
            Transport.send(message);
            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
    }
}