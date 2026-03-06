<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Users"%>
<%
    Users admin = (Users) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getUserType())) {
        response.sendRedirect(request.getContextPath() + "/web/login.jsp");
        return;
    }

    List<Users> list = (List<Users>) request.getAttribute("listUsers");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Management</title>

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">

        <style>
            * {
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:'Segoe UI',sans-serif;
            }

            body {
                background:#f0f2f5;
                display:flex;
                min-height:100vh;
            }

            /* SIDEBAR */
            .sidebar {
                width:240px;
                background:#1a5d36;
                color:white;
                padding:25px 0;
                position:fixed;
                height:100%;
            }

            .logo {
                padding:0 25px;
                margin-bottom:40px;
                font-weight:bold;
                font-size:20px;
            }

            .nav-item {
                padding:15px 25px;
                display:flex;
                align-items:center;
                gap:10px;
                color:white;
                text-decoration:none;
                opacity:0.8;
                transition:0.3s;
            }

            .nav-item:hover {
                opacity:1;
                background:rgba(255,255,255,0.08);
            }

            .active {
                background:rgba(255,255,255,0.15);
                opacity:1;
            }

            /* CONTENT */
            .content {
                flex:1;
                padding:30px;
                margin-left:240px;
            }

            .header {
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:25px;
            }

            .table-card {
                background:white;
                padding:20px;
                border-radius:12px;
                box-shadow:0 2px 10px rgba(0,0,0,0.05);
            }

            table {
                width:100%;
                border-collapse:collapse;
                margin-top:15px;
            }

            th, td {
                padding:12px;
                text-align:left;
                border-bottom:1px solid #eee;
            }

            th {
                background:#f9fafb;
                font-size:13px;
                color:#555;
            }

            .btn {
                padding:6px 12px;
                border:none;
                border-radius:5px;
                cursor:pointer;
                font-size:12px;
                text-decoration:none;
                display:inline-block;
            }

            .btn-create {
                background:#198754;
                color:white;
            }

            .btn-edit {
                background:#ffc107;
                color:white;
            }

            .btn-delete {
                background:#dc3545;
                color:white;
            }

            .btn-create:hover {
                background:#157347;
            }
            .btn-edit:hover {
                background:#e0a800;
            }
            .btn-delete:hover {
                background:#c82333;
            }
        </style>
    </head>

    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="logo">
                <i class="ti-dashboard"></i> Admin Panel
            </div>

            <a href="<%=request.getContextPath()%>/admin" class="nav-item">
                <i class="ti-layout-grid2"></i> Dashboard
            </a>

            <a href="<%=request.getContextPath()%>/users" class="nav-item active">
                <i class="ti-user"></i> Quản lý Users
            </a>

            <a href="<%=request.getContextPath()%>/packages" class="nav-item">
                <i class="ti-package"></i> Quản lý Gói Điện
            </a>

            <a href="<%=request.getContextPath()%>/orders" class="nav-item">
                <i class="ti-shopping-cart"></i> Quản lý Đơn Hàng
            </a>

            <a href="<%=request.getContextPath()%>/logout" class="nav-item">
                <i class="ti-power-off"></i> Đăng Xuất
            </a>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="content">

            <div class="header">
                <h2>User Management</h2>
                <div>
                    Xin chào, <strong><%= admin.getName()%></strong>
                </div>
            </div>

            <div class="table-card">
                <a href="users?action=create" class="btn btn-create">
                    <i class="ti-plus"></i> Tạo User Mới
                </a>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Email</th>
                            <th>Loại</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (list != null) {
                        for (Users u : list) {%>
                        <tr>
                            <td><%=u.getUserId()%></td>
                            <td><%=u.getName()%></td>
                            <td><%=u.getEmail()%></td>
                            <td><%=u.getUserType()%></td>
                            <td>
                                <a href="users?action=edit&id=<%=u.getUserId()%>" 
                                   class="btn btn-edit">
                                    Sửa
                                </a>

                                <a href="users?action=delete&id=<%=u.getUserId()%>" 
                                   class="btn btn-delete"
                                   onclick="return confirm('Delete user?')">
                                    Xóa
                                </a>
                            </td>
                        </tr>
                        <%   }
                    }%>
                    </tbody>
                </table>
            </div>

        </main>

    </body>
</html>