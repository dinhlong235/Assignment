<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - VOLTSTREAM</title>
    <style>
        body{ margin:0; font-family: 'Segoe UI', sans-serif; background:#f1f5f9; display:flex; justify-content:center; align-items:center; height:100vh; }
        .login-wrapper{ width:100%; max-width:420px; }
        .logo{ text-align:center; font-size:28px; font-weight:bold; color:#2563eb; margin-bottom:25px; }
        .card{ background:white; padding:35px; border-radius:16px; box-shadow:0 10px 25px rgba(0,0,0,0.06); }
        h2{ margin:0 0 10px 0; text-align:center; font-weight:600; color:#0f172a; }
        .subtitle { text-align: center; font-size: 14px; color: #64748b; margin-bottom: 25px; line-height: 1.5; }
        .form-group{ margin-bottom:18px; }
        .form-group label{ display:block; margin-bottom:6px; font-size:14px; color:#334155; }
        .form-group input{ width:100%; padding:10px 12px; border-radius:8px; border:1px solid #cbd5e1; font-size:14px; transition:0.2s; box-sizing: border-box; }
        .form-group input:focus{ border-color:#2563eb; outline:none; box-shadow:0 0 0 2px rgba(37,99,235,0.15); }
        .btn-login{ width:100%; padding:12px; border:none; border-radius:8px; background:#2563eb; color:white; font-weight:500; font-size:15px; cursor:pointer; transition:0.2s; margin-top:5px; }
        .btn-login:hover{ background:#1e40af; }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="logo">⚡ VOLTSTREAM</div>
    <div class="card">
        <h2>Create New Password</h2>
        <div class="subtitle">Please enter your new password below.</div>

        <form action="${pageContext.request.contextPath}/update-password" method="post">
            
            <input type="hidden" name="email" value="${param.email}">
            <input type="hidden" name="token" value="${param.token}">

            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword" required placeholder="Enter new password">
            </div>

            <div class="form-group">
                <label>Confirm New Password</label>
                <input type="password" name="confirmPassword" required placeholder="Confirm new password">
            </div>

            <button type="submit" class="btn-login">
                Update Password
            </button>
        </form>
    </div>
</div>

</body>
</html>