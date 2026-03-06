<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.ServicePackages"%>
<%@page import="model.Users"%>

<%
    Users admin = (Users) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getUserType())) {
        response.sendRedirect(request.getContextPath() + "/web/login.jsp");
        return;
    }

    List<ServicePackages> list
            = (List<ServicePackages>) request.getAttribute("listPackages");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Gói Điện</title>

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">

        <style>
            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:'Segoe UI',sans-serif;
            }

            body{
                background:#f0f2f5;
                display:flex;
                min-height:100vh;
            }

            /* SIDEBAR */
            .sidebar{
                width:240px;
                background:#1a5d36;
                color:white;
                padding:25px 0;
                position:fixed;
                height:100%;
            }

            .logo{
                padding:0 25px;
                margin-bottom:40px;
                font-weight:bold;
                font-size:20px;
            }

            .nav-item{
                padding:15px 25px;
                display:flex;
                align-items:center;
                gap:10px;
                color:white;
                text-decoration:none;
                opacity:0.8;
                transition:0.3s;
            }

            .nav-item:hover{
                opacity:1;
                background:rgba(255,255,255,0.08);
            }

            /* CONTENT */
            .content{
                flex:1;
                padding:30px;
                margin-left:240px;
            }

            .header{
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:25px;
            }

            .table-card{
                background:white;
                padding:20px;
                border-radius:12px;
                box-shadow:0 2px 10px rgba(0,0,0,0.05);
            }

            table{
                width:100%;
                border-collapse:collapse;
                margin-top:15px;
            }

            th, td{
                padding:12px;
                text-align:left;
                border-bottom:1px solid #eee;
            }

            th{
                background:#f9fafb;
                font-size:13px;
                color:#555;
            }

            .btn{
                padding:6px 12px;
                border:none;
                border-radius:5px;
                cursor:pointer;
                font-size:12px;
                text-decoration:none;
                color:white;
            }

            .btn-add{
                background:#1a5d36;
            }

            .btn-edit{
                background:#ffc107;
            }

            .btn-delete{
                background:#dc3545;
            }

            .btn:hover{
                opacity:0.85;
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

            <a href="<%=request.getContextPath()%>/users" class="nav-item">
                <i class="ti-user"></i> Quản lý Users
            </a>

            <a href="<%=request.getContextPath()%>/packages" class="nav-item" style="background:rgba(255,255,255,0.1); opacity:1;">
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
                <h2>Quản lý Gói Điện</h2>
                <div>
                    Xin chào, <strong><%= admin.getName()%></strong>
                </div>
            </div>

            <div class="table-card">

                <a href="<%=request.getContextPath()%>/packages?action=create"
                   class="btn btn-add">
                    ➕ Thêm Gói
                </a>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Giá</th>
                            <th>Loại</th>
                            <th>Mô tả</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>

                        <% if (list != null && !list.isEmpty()) {
                    for (ServicePackages p : list) {%>

                        <tr>
                            <td><%=p.getPackageId()%></td>
                            <td><%=p.getName()%></td>
                            <td><%=p.getPrice()%> đ</td>
                            <td><%=p.getPackageType()%></td>
                            <td><%=p.getDescription()%></td>
                            <td>
                                <a class="btn btn-edit"
                                   href="<%=request.getContextPath()%>/packages?action=edit&id=<%=p.getPackageId()%>">
                                    Sửa
                                </a>

                                <a class="btn btn-delete"
                                   href="<%=request.getContextPath()%>/packages?action=delete&id=<%=p.getPackageId()%>"
                                   onclick="return confirm('Xóa gói này?')">
                                    Xóa
                                </a>
                            </td>
                        </tr>

                        <% }
            } else { %>

                        <tr>
                            <td colspan="6">Chưa có gói nào.</td>
                        </tr>

                        <% }%>

                    </tbody>
                </table>

            </div>

        </main>

    </body>
</html>