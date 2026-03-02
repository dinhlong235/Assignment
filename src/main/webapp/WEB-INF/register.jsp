<%-- 
    Document   : register
    Created on : 20 thg 2, 2026, 22:37:45
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký - Năng Lượng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
        <link rel="stylesheet" href="asset/css/global.css">
        <link rel="stylesheet" href="asset/css/login.css">
    </head>
    <body>
        <div class="container">
            <div class="login-box">
                
                <div class="logo-container">
                    <svg width="40" height="40" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="50" cy="50" r="45" fill="#2d8b4e" />
                        <path d="M30 70 C30 70, 20 40, 50 20 C80 40, 70 70, 70 70 C60 85, 40 85, 30 70 Z" fill="#ffffff" />
                        <path d="M50 25 Q45 50 35 65" stroke="#2d8b4e" stroke-width="4" fill="none" stroke-linecap="round"/>
                    </svg>
                    <span class="logo-text">Năng Lượng</span>
                </div>

                <h1 class="box-title">Đăng ký</h1>
                
                <form id="registerForm" action="register" method="post" class="login-form">
                    
                    <div class="input-group">
                        <input type="text" name="fullname" placeholder="Họ và Tên" required>
                    </div>

                    <div class="input-group">
                        <input type="email" name="email" placeholder="Email" required>
                    </div>
                    
                    <div class="input-group">
                        <input type="password" name="password" id="regPassword" placeholder="Mật khẩu" required>
                        <i class="ti-eye toggle-password"></i>
                    </div>

                    <div class="input-group" style="margin-bottom: 25px;">
                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                        <i class="ti-eye toggle-password"></i>
                    </div>

                    <input type="submit" value="Đăng ký" class="submit-btn"/>
                    
                    <div class="form-footer">
                        <div class="login-signup">
                            Đã có tài khoản? <a href="login.jsp">Đăng nhập</a>
                        </div>
                    </div>
                </form>
                
            </div>
        </div>

        <script>
            document.getElementById('registerForm').addEventListener('submit', function(event) {
                const password = document.getElementById('regPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (password !== confirmPassword) {
                    event.preventDefault(); // Ngăn form gửi đi
                    alert('Lỗi: Mật khẩu xác nhận không khớp! Vui lòng kiểm tra lại.');
                }
            });
            // Đoạn code xử lý tính năng Ẩn/Hiện mật khẩu
            document.querySelectorAll('.toggle-password').forEach(function(icon) {
                icon.addEventListener('click', function() {
                // Tìm ô input nằm ngay trước cái icon con mắt này
                const input = this.previousElementSibling;
        
        // Nếu đang là password (bị ẩn) -> Đổi thành text (hiện chữ)
        if (input.type === 'password') {
            input.type = 'text';
            this.style.color = '#2b8b4a'; // Đổi icon sang màu xanh lá cho đẹp
        } 
        // Nếu đang là text (hiện chữ) -> Đổi lại thành password (ẩn đi)
        else {
            input.type = 'password';
            this.style.color = '#64748b'; // Trả lại màu xám ban đầu
        }
    });
});
        </script>
    </body>
</html>