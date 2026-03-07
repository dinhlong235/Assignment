<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - VOLTSTREAM</title>

    <style>
        body{
            margin:0;
            font-family: 'Segoe UI', sans-serif;
            background:#f1f5f9;
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
        }

        .login-wrapper{
            width:100%;
            max-width:420px;
        }

        .logo{
            text-align:center;
            font-size:28px;
            font-weight:bold;
            color:#2563eb;
            margin-bottom:25px;
        }

        .card{
            background:white;
            padding:35px;
            border-radius:16px;
            box-shadow:0 10px 25px rgba(0,0,0,0.06);
        }

        h2{
            margin:0 0 25px 0;
            text-align:center;
            font-weight:600;
            color:#0f172a;
        }

        .form-group{
            margin-bottom:18px;
        }

        .form-group label{
            display:block;
            margin-bottom:6px;
            font-size:14px;
            color:#334155;
        }

        .form-group input{
            width:100%;
            padding:10px 12px;
            border-radius:8px;
            border:1px solid #cbd5e1;
            font-size:14px;
            transition:0.2s;
        }

        .form-group input:focus{
            border-color:#2563eb;
            outline:none;
            box-shadow:0 0 0 2px rgba(37,99,235,0.15);
        }

        .btn-login{
            width:100%;
            padding:12px;
            border:none;
            border-radius:8px;
            background:#2563eb;
            color:white;
            font-weight:500;
            font-size:15px;
            cursor:pointer;
            transition:0.2s;
            margin-top:5px;
        }

        .btn-login:hover{
            background:#1e40af;
        }

        .register{
            margin-top:18px;
            text-align:center;
            font-size:14px;
            color:#64748b;
        }

        .register a{
            text-decoration:none;
            color:#2563eb;
            font-weight:500;
        }

        .register a:hover{
            text-decoration:underline;
        }

        .footer{
            margin-top:25px;
            text-align:center;
            font-size:12px;
            color:#94a3b8;
        }

    </style>
</head>

<body>

<div class="login-wrapper">

    <div class="logo">
        ⚡ VOLTSTREAM
    </div>

    <div class="card">

        <h2>Sign in to your account</h2>
        <%-- Hiển thị lỗi (Màu đỏ) --%>
                <% if(request.getAttribute("error") != null) { %>
            <div style="color: #dc2626; background: #fee2e2; padding: 10px; border-radius: 8px; margin-bottom: 15px; text-align: center; font-size: 14px;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <%-- Hiển thị thành công (Màu xanh) --%>
                <% if(request.getAttribute("message") != null) { %>
            <div style="color: #16a34a; background: #dcfce7; padding: 10px; border-radius: 8px; margin-bottom: 15px; text-align: center; font-size: 14px;">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>

            <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <div style="text-align: right; margin-top: -10px; margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/web/forgot-password.jsp" style="font-size: 13px; color: #3b82f6; text-decoration: none; font-weight: 500;">
                Forgot password?
            </a>
        </div>

        <button type="submit" class="btn-login">
            Login
        </button>
    </div>

    <div class="footer">
        © 2026 VOLTSTREAM Energy Management
    </div>

</div>

</body>
</html>