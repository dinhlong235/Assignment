<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập - Năng Lượng</title>
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

                <h1 class="box-title">Đăng nhập</h1>
                
                <form action="LoginServlet" method="post" class="login-form">
                    <div class="input-group">
                        <input type="text" name="username" placeholder="Tên đăng nhập" required>
                    </div>
                    
                    <div class="input-group">
                        <input type="password" name="password" id="password" placeholder="Mật khẩu" required>
                        <i class="ti-eye toggle-password" id="togglePassword" style="cursor: pointer;"></i>
                    </div>

                    <div class="remember-container">
                        <input type="checkbox" id="remember" name="remember"/>
                        <label for="remember">Ghi nhớ tôi</label>
                    </div>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="error-text" style="color: #dc2626; font-size: 14px; margin-bottom: 15px; text-align: center;">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <input type="submit" value="Đăng nhập" class="submit-btn"/>
                    
                    <div class="form-footer">
                        <a href="#" class="forgot-pw">Quên mật khẩu?</a>
                        <div class="login-signup">
                            Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script>
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#password');

            togglePassword.addEventListener('click', function (e) {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.classList.toggle('ti-eye');
                this.classList.toggle('ti-view-grid'); // Hoặc đổi màu icon để biết đang hiện
            });
        </script>
    </body>
</html>