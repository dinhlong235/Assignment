<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Orders"%>
<%@page import="model.Users"%>

<%
    Users admin = (Users) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getUserType())) {
        response.sendRedirect(request.getContextPath() + "/web/login.jsp");
        return;
    }

    List<Orders> list
            = (List<Orders>) request.getAttribute("listOrders");

    String selectedStatus = request.getParameter("status");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Đơn hàng</title>

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">

        <style>
            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:'Segoe UI';
            }
            body{
                background:#f0f2f5;
                display:flex;
                min-height:100vh;
            }

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
                gap:10px;
                color:white;
                text-decoration:none;
                opacity:0.85;
            }
            .nav-item:hover{
                background:rgba(255,255,255,0.08);
                opacity:1;
            }

            .content{
                flex:1;
                padding:30px;
                margin-left:240px;
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
            th,td{
                padding:12px;
                border-bottom:1px solid #eee;
            }
            th{
                background:#f9fafb;
                color:#555;
            }

            .btn{
                padding:6px 10px;
                border-radius:5px;
                font-size:12px;
                text-decoration:none;
                color:white;
            }
            .btn-approve{
                background:#28a745;
            }
            .btn-cancel{
                background:#dc3545;
            }
            .btn-view{
                background:#007bff;
            }

            .filter{
                margin-bottom:15px;
            }
            select{
                padding:5px;
            }
        </style>
    </head>

    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="logo"><i class="ti-dashboard"></i> Admin Panel</div>

            <a href="<%=request.getContextPath()%>/admin" class="nav-item">
                <i class="ti-layout-grid2"></i> Dashboard
            </a>

            <a href="<%=request.getContextPath()%>/users" class="nav-item">
                <i class="ti-user"></i> Quản lý Users
            </a>

            <a href="<%=request.getContextPath()%>/packages" class="nav-item">
                <i class="ti-package"></i> Quản lý Gói Điện
            </a>

            <a href="<%=request.getContextPath()%>/orders" 
               class="nav-item" 
               style="background:rgba(255,255,255,0.1);opacity:1;">
                <i class="ti-shopping-cart"></i> Quản lý Đơn Hàng
            </a>

            <a href="<%=request.getContextPath()%>/logout" class="nav-item">
                <i class="ti-power-off"></i> Đăng Xuất
            </a>
        </aside>

        <!-- MAIN -->
        <main class="content">

            <h2>Quản lý Đơn hàng</h2>

            <div class="table-card">

                <form method="get" action="orders" class="filter">
                    Lọc trạng thái:
                    <select name="status" onchange="this.form.submit()">
                        <option value="">-- Tất cả --</option>
                        <option value="pending" <%= "pending".equals(selectedStatus) ? "selected" : ""%>>Pending</option>
                        <option value="active" <%= "active".equals(selectedStatus) ? "selected" : ""%>>Active</option>
                        <option value="cancelled" <%= "cancelled".equals(selectedStatus) ? "selected" : ""%>>Cancelled</option>
                        <option value="expired" <%= "expired".equals(selectedStatus) ? "selected" : ""%>>Expired</option>
                    </select>
                </form>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Package</th>
                            <th>Ngày đặt</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>

                        <% if (list != null && !list.isEmpty()) {
        for (Orders o : list) {%>

                        <tr>
                            <td><%=o.getOrderId()%></td>
                            <td><%=o.getUserId().getName()%></td>
                            <td><%=o.getPackageId().getName()%></td>
                            <td><%=o.getOrderDate()%></td>
                            <td><%=o.getStatus()%></td>
                            <td>

                                <a class="btn btn-view"
                                   href="orders?action=view&id=<%=o.getOrderId()%>">
                                    Xem
                                </a>

                                <% if ("pending".equalsIgnoreCase(o.getStatus())) {%>

                                <a class="btn btn-approve"
                                   href="orders?action=approve&id=<%=o.getOrderId()%>">
                                    Duyệt
                                </a>

                                <a class="btn btn-cancel"
                                   href="orders?action=cancel&id=<%=o.getOrderId()%>">
                                    Hủy
                                </a>

                                <% } else if ("active".equalsIgnoreCase(o.getStatus())) {%>

                                <a class="btn btn-cancel"
                                   href="orders?action=cancel&id=<%=o.getOrderId()%>">
                                    Hủy
                                </a>

                                <% } %>

                            </td>
                        </tr>

                        <% }
} else { %>
                        <tr><td colspan="6">Không có đơn hàng</td></tr>
                        <% }%>

                    </tbody>
                </table>

            </div>
        </main>
    </body>
</html>