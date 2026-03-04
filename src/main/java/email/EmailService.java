package email;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.InputStream;
import java.util.Properties;

public class EmailService {

    private String fromEmail;
    private String password;

    public EmailService() {
        loadConfig();
    }

    private void loadConfig() {
        try {
            Properties config = new Properties();
            InputStream input = getClass()
                    .getClassLoader()
                    .getResourceAsStream("email.properties");

            config.load(input);

            fromEmail = config.getProperty("email.username");
            password = config.getProperty("email.password");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendOrderEmail(String toEmail,
                               String userName,
                               String supplierName,
                               String packageName,
                               String price,
                               String dueDate) {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));
            message.setSubject("Xác nhận đăng ký dịch vụ điện", "UTF-8");

            // ===== HTML CONTENT =====
            String content = "<div style='font-family:Arial;'>"
                    + "<h2 style='color:#2E86C1;'>Xin chào " + userName + "</h2>"
                    + "<p>Cảm ơn bạn đã đăng ký dịch vụ điện năng.</p>"
                    + "<hr>"
                    + "<p><b>Supplier:</b> " + supplierName + "</p>"
                    + "<p><b>Gói dịch vụ:</b> " + packageName + "</p>"
                    + "<p><b>Giá:</b> " + price + " VND</p>"
                    + "<p><b>Hạn thanh toán:</b> " + dueDate + "</p>"
                    + "<hr>"
                    + "<p>Vui lòng thanh toán đúng hạn để kích hoạt hợp đồng.</p>"
                    + "<p style='color:gray;'>ElectricityWeb Team</p>"
                    + "</div>";

            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);

            System.out.println("Email sent successfully!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}