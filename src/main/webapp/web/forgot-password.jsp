<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - VOLTSTREAM</title>

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
            margin:0 0 10px 0;
            text-align:center;
            font-weight:600;
            color:#0f172a;
        }

        .subtitle {
            text-align: center;
            font-size: 14px;
            color: #64748b;
            margin-bottom: 25px;
            line-height: 1.5;
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
            box-sizing: border-box; /* Giúp input không bị tràn viền */
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

        <h2>Reset Password</h2>
        <div class="subtitle">Enter your email address and we'll send you a link to reset your password.</div>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" required placeholder="Enter your registered email">
            </div>

            <button type="submit" class="btn-login">
                Send Reset Link
            </button>

        </form>

        <div class="register">
            Remember your password?
            <a href="${pageContext.request.contextPath}/web/login.jsp">
                Back to Login
            </a>
        </div>

    </div>

    <div class="footer">
        © 2026 VOLTSTREAM Energy Management
    </div>

</div>

</body>
</html>