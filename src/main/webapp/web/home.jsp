<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>VOLTSTREAM Dashboard</title>

        <style>
            body{
                margin:0;
                font-family:Segoe UI, sans-serif;
                background:#f1f5f9;
            }

            .layout{
                display:flex;
                height:100vh;
            }

            /* SIDEBAR */
            .sidebar{
                width:260px;
                background:#0f1b2d;
                color:white;
                display:flex;
                flex-direction:column;
            }

            .logo{
                padding:20px;
                font-size:22px;
                font-weight:bold;
                color:#38bdf8;
                border-bottom:1px solid rgba(255,255,255,0.08);
            }

            .profile{
                padding:18px;
                display:flex;
                align-items:center;
                gap:12px;
                cursor:pointer;
                transition:0.2s;
                border-bottom:1px solid rgba(255,255,255,0.08);
            }

            .profile:hover{
                background:#1e293b;
            }

            .avatar{
                width:45px;
                height:45px;
                border-radius:50%;
                background:linear-gradient(135deg,#3b82f6,#2563eb);
                display:flex;
                align-items:center;
                justify-content:center;
                font-weight:bold;
                font-size:18px;
                color:white;
            }

            .profile-info small{
                color:#94a3b8;
            }

            .menu{
                flex:1;
                padding:15px;
            }

            .menu a{
                display:flex;
                align-items:center;
                gap:10px;
                padding:12px;
                border-radius:8px;
                text-decoration:none;
                color:#cbd5e1;
                margin-bottom:6px;
                transition:0.2s;
            }

            .menu a:hover{
                background:#1e293b;
                color:white;
            }

            .menu a.active{
                background:linear-gradient(90deg,#2563eb,#3b82f6);
                color:white;
            }

            .logout{
                padding:15px;
                border-top:1px solid rgba(255,255,255,0.08);
            }

            .logout a{
                text-decoration:none;
                color:#cbd5e1;
            }

            /* MAIN */
            .main{
                flex:1;
                padding:40px;
            }

            .big-title{
                font-size:28px;
                font-weight:bold;
                margin-bottom:5px;
            }

            .subtitle{
                color:#64748b;
                margin-bottom:30px;
            }

            /* GRID */
            .services{
                display:grid;
                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
                gap:20px;
            }

            .card{
                background:white;
                padding:25px;
                border-radius:14px;
                box-shadow:0 6px 18px rgba(0,0,0,0.05);
                transition:0.25s;
            }

            .card:hover{
                transform:translateY(-6px);
                box-shadow:0 12px 24px rgba(0,0,0,0.08);
            }

            .card h5{
                margin:0 0 10px 0;
                font-size:18px;
            }

            .card p{
                color:#64748b;
                font-size:14px;
                margin-bottom:20px;
            }

            .btn{
                padding:8px 16px;
                border:none;
                border-radius:6px;
                cursor:pointer;
                font-weight:500;
            }

            .btn-blue{
                background:#2563eb;
                color:white;
            }

            .btn-green{
                background:#16a34a;
                color:white;
            }

            .btn-orange{
                background:#ea580c;
                color:white;
            }

            .btn:hover{
                opacity:0.9;
            }

            .alert-success{
                background:#dcfce7;
                color:#166534;
                padding:12px;
                border-radius:8px;
                margin-bottom:20px;
            }

        </style>
    </head>

    <body>

        <%
            Users user = (Users) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String successMessage = (String) session.getAttribute("successMessage");
        %>

        <div class="layout">

            <!-- SIDEBAR -->
            <div class="sidebar">

                <div class="logo">
                    ⚡ VOLTSTREAM
                </div>

                <a href="${pageContext.request.contextPath}/account" style="text-decoration:none; color:inherit;">
                    <div class="profile">
                        <div class="avatar">
                            <%= user.getName().substring(0, 1).toUpperCase()%>
                        </div>
                        <div class="profile-info">
                            <div><%= user.getName()%></div>
                            <small>Power Manager</small>
                        </div>
                    </div>
                </a>

                <div class="menu">
                    <a class="active" href="${pageContext.request.contextPath}/home">🏠 Dashboard</a>
                    <a href="${pageContext.request.contextPath}/OrderServlet">📄 Đăng kí dịch vụ</a>
                    <a href="${pageContext.request.contextPath}/OrderServlet">💰 Ước tính điện năng</a>
                    <a href="#">🧾 Updating</a>
                    <a href="#">📊 Updating</a>
                    <a href="#">🔔 Updating</a>
                </div>

                <div class="logout">
                    <a href="${pageContext.request.contextPath}/logout">⬅ Logout</a>
                </div>

            </div>

            <!-- MAIN CONTENT -->
            <div class="main">

                <div class="big-title">DASHBOARD</div>
                <div class="subtitle">
                    Welcome back, <%= user.getName()%> 👋
                </div>

                <% if (successMessage != null) {%>
                <div class="alert-success">
                    <%= successMessage%>
                </div>
                <%
                        session.removeAttribute("successMessage");
                    }
                %>

                <h3 style="margin-bottom:20px;">🔥 Gói dịch vụ nổi bật</h3>

                <div class="services">

                    <div class="card">
                        <h5>Basic Plan</h5>
                        <p>Phù hợp hộ gia đình nhỏ</p>
                        <button class="btn btn-blue">Xem chi tiết</button>
                    </div>

                    <div class="card">
                        <h5>Premium Plan</h5>
                        <p>Tiết kiệm điện tối ưu</p>
                        <button class="btn btn-green">Xem chi tiết</button>
                    </div>

                    <div class="card">
                        <h5>Enterprise Plan</h5>
                        <p>Dành cho doanh nghiệp</p>
                        <button class="btn btn-orange">Xem chi tiết</button>
                    </div>

                </div>

            </div>

        </div>

    </body>
</html>