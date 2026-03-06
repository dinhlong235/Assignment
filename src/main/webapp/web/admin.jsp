<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users"%>
<%@page import="java.util.List"%>

<%
    Users admin = (Users) session.getAttribute("user");

    if (admin == null || !"admin".equals(admin.getUserType())) {
        response.sendRedirect(request.getContextPath() + "/web/login.jsp");
        return;
    }

    Long totalUsers = (Long) request.getAttribute("totalUsers");
    Long totalPackages = (Long) request.getAttribute("totalPackages");
    Long pendingOrders = (Long) request.getAttribute("pendingOrders");
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");

    List<Users> users = (List<Users>) request.getAttribute("recentUsers");

    if (totalUsers == null) {
        totalUsers = 0L;
    }
    if (totalPackages == null) {
        totalPackages = 0L;
    }
    if (pendingOrders == null) {
        pendingOrders = 0L;
    }
    if (totalRevenue == null)
        totalRevenue = 0.0;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>

            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:Segoe UI;
            }

            body{
                background:#f4f6f9;
                display:flex;
            }

            /* SIDEBAR */

            .sidebar{
                width:230px;
                background:#1a5d36;
                height:100vh;
                position:fixed;
                color:white;
                padding-top:25px;
            }

            .logo{
                padding:20px;
                font-size:20px;
                font-weight:bold;
            }

            .nav-item{
                display:block;
                padding:14px 25px;
                color:white;
                text-decoration:none;
                opacity:0.8;
            }

            .nav-item:hover{
                background:rgba(255,255,255,0.1);
                opacity:1;
            }

            /* CONTENT */

            .content{
                margin-left:230px;
                flex:1;
                padding:30px;
            }

            .header{
                display:flex;
                justify-content:space-between;
                margin-bottom:25px;
            }

            /* KPI */

            .kpi-row{
                display:grid;
                grid-template-columns:repeat(4,1fr);
                gap:20px;
                margin-bottom:30px;
            }

            .kpi-card{
                background:white;
                padding:20px;
                border-radius:10px;
                box-shadow:0 3px 10px rgba(0,0,0,0.05);
            }

            .kpi-title{
                color:#888;
                font-size:13px;
            }

            .kpi-value{
                font-size:24px;
                font-weight:bold;
                color:#1a5d36;
                margin-top:5px;
            }

            /* CHART */

            .chart-row{
                display:grid;
                grid-template-columns:repeat(3,1fr);
                gap:20px;
                margin-bottom:30px;
            }

            .chart-card{
                background:white;
                padding:20px;
                border-radius:10px;
                box-shadow:0 2px 8px rgba(0,0,0,0.05);
            }

            /* TABLE */

            .table-card{
                background:white;
                padding:20px;
                border-radius:10px;
                box-shadow:0 2px 8px rgba(0,0,0,0.05);
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
                font-size:13px;
            }

            .btn{
                padding:6px 12px;
                border:none;
                border-radius:5px;
                cursor:pointer;
                font-size:12px;
            }

            .btn-edit{
                background:#ffc107;
                color:white;
            }

            .btn-delete{
                background:#dc3545;
                color:white;
            }

        </style>

    </head>

    <body>

        <!-- SIDEBAR -->

        <div class="sidebar">

            <div class="logo">
                <i class="ti-dashboard"></i> Admin
            </div>

            <a class="nav-item" href="<%=request.getContextPath()%>/admin">
                <i class="ti-layout-grid2"></i> Dashboard
            </a>

            <a class="nav-item" href="<%=request.getContextPath()%>/users">
                <i class="ti-user"></i> Quản lý Users
            </a>

            <a class="nav-item" href="<%=request.getContextPath()%>/packages">
                <i class="ti-package"></i> Quản lý Gói Điện
            </a>

            <a class="nav-item" href="<%=request.getContextPath()%>/orders">
                <i class="ti-shopping-cart"></i> Quản lý Đơn Hàng
            </a>

            <a class="nav-item" href="<%=request.getContextPath()%>/logout">
                <i class="ti-power-off"></i> Đăng Xuất
            </a>

        </div>


        <!-- CONTENT -->

        <div class="content">

            <div class="header">
                <h2>Dashboard</h2>
                <div>Xin chào <b><%=admin.getName()%></b></div>
            </div>


            <!-- KPI -->

            <div class="kpi-row">

                <div class="kpi-card">
                    <div class="kpi-title">Total Users</div>
                    <div class="kpi-value"><%=totalUsers%></div>
                </div>

                <div class="kpi-card">
                    <div class="kpi-title">Total Packages</div>
                    <div class="kpi-value"><%=totalPackages%></div>
                </div>

                <div class="kpi-card">
                    <div class="kpi-title">Pending Orders</div>
                    <div class="kpi-value"><%=pendingOrders%></div>
                </div>

                <div class="kpi-card">
                    <div class="kpi-title">Revenue</div>
                    <div class="kpi-value"><%=String.format("%,.0f", totalRevenue)%> đ</div>
                </div>

            </div>


            <!-- CHART -->

            <div class="chart-row">

                <div class="chart-card">
                    <canvas id="userChart"></canvas>
                </div>

                <div class="chart-card">
                    <canvas id="revenueChart"></canvas>
                </div>

                <div class="chart-card">
                    <canvas id="orderChart"></canvas>
                </div>

            </div>


            <!-- TABLE -->

            <div class="table-card">

                <h3>Recent Users</h3>

                <table>

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Type</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            if (users != null) {
                                for (Users u : users) {
                        %>

                        <tr>
                            <td><%=u.getUserId()%></td>
                            <td><%=u.getName()%></td>
                            <td><%=u.getEmail()%></td>
                            <td><%=u.getUserType()%></td>

                            <td>

                                <a href="<%=request.getContextPath()%>/users?action=edit&id=<%=u.getUserId()%>">
                                    <button class="btn btn-edit">Edit</button>
                                </a>

                                <a href="<%=request.getContextPath()%>/users?action=delete&id=<%=u.getUserId()%>"
                                   onclick="return confirm('Delete user?')">

                                    <button class="btn btn-delete">Delete</button>

                                </a>

                            </td>

                        </tr>

                        <% }
                            }%>

                    </tbody>

                </table>

            </div>

        </div>


        <script>

            /* USERS CHART */

            new Chart(document.getElementById("userChart"), {
                type: "bar",
                data: {
                    labels: ["Users", "Packages", "Pending Orders"],
                    datasets: [{
                            label: "System Overview",
                            data: [<%=totalUsers%>, <%=totalPackages%>, <%=pendingOrders%>],
                            backgroundColor: [
                                "#4CAF50",
                                "#FFC107",
                                "#2196F3"
                            ]
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {display: false}
                    }
                }
            });


            /* REVENUE CHART */

            new Chart(document.getElementById("revenueChart"), {
                type: "line",
                data: {
                    labels: ["Revenue"],
                    datasets: [{
                            label: "Total Revenue",
                            data: [<%=totalRevenue%>],
                            borderColor: "#1a5d36",
                            backgroundColor: "rgba(26,93,54,0.2)",
                            fill: true,
                            tension: 0.4
                        }]
                }
            });


            /* ORDER CHART */

            new Chart(document.getElementById("orderChart"), {
                type: "doughnut",
                data: {
                    labels: ["Pending Orders", "Other"],
                    datasets: [{
                            data: [<%=pendingOrders%>, 5],
                            backgroundColor: [
                                "#ff9800",
                                "#4CAF50"
                            ]
                        }]
                }
            });

        </script>


    </body>
</html>