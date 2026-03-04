<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Users"%>
<%@page import="model.ServicePackages"%>
<%@page import="controller.ServicePackagesJpaController"%>
<%@page import="jakarta.persistence.Persistence"%>
<%@page import="jakarta.persistence.EntityManagerFactory"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Năng Lượng - Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #f0f2f5; display: flex; min-height: 100vh; }

        /* 1. SIDEBAR */
        .sidebar { width: 240px; background-color: #1a5d36; color: white; padding: 25px 0; position: fixed; height: 100%; }
        .logo { display: flex; align-items: center; padding: 0 25px; margin-bottom: 40px; font-weight: bold; font-size: 20px; gap: 10px; }
        .nav-menu { list-style: none; }
        .nav-item { padding: 15px 25px; display: flex; align-items: center; gap: 15px; cursor: pointer; opacity: 0.7; transition: 0.3s; color: white; text-decoration: none; }
        .nav-item.active { background: rgba(255,255,255,0.1); opacity: 1; border-left: 4px solid #fff; }
        .nav-item:hover { opacity: 1; background: rgba(255,255,255,0.05); }

        /* 2. MAIN CONTENT */
        .content { flex: 1; padding: 25px; margin-left: 240px; /* Tránh đè sidebar */ }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        
        /* KPI Cards */
        .kpi-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 25px; }
        .kpi-card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .kpi-title { color: #888; font-size: 13px; margin-bottom: 8px; }
        .kpi-value { font-size: 22px; font-weight: bold; color: #1a5d36; }

        /* Charts */
        .chart-row { display: grid; grid-template-columns: 1.5fr 1fr; gap: 20px; margin-bottom: 25px; }
        .chart-card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }

        /* Info Boxes */
        .info-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px; }
        .alert-box { background: #fff8ee; border: 1px solid #ffe8cc; padding: 15px; border-radius: 12px; display: flex; gap: 15px; }
        .tip-box { background: #f0fdf4; border: 1px solid #dcfce7; padding: 15px; border-radius: 12px; display: flex; gap: 15px; }

        /* --- CSS CHO PHẦN ĐĂNG KÝ --- */
        .registration-section { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-top: 25px; }
        .reg-header { font-size: 18px; font-weight: bold; color: #1a5d36; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        
        .filter-form { display: flex; gap: 15px; background: #f8f9fa; padding: 15px; border-radius: 8px; align-items: center; }
        .filter-form select { padding: 8px; border: 1px solid #ddd; border-radius: 5px; min-width: 150px; }
        .btn-green { background: #1a5d36; color: white; border: none; padding: 8px 20px; border-radius: 5px; cursor: pointer; font-weight: 500; }
        .btn-green:hover { background: #144528; }

        .packages-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 20px; }
        .package-item { border: 1px solid #eee; border-radius: 8px; padding: 15px; transition: 0.3s; position: relative; overflow: hidden; display: flex; flex-direction: column; justify-content: space-between; }
        .package-item:hover { border-color: #1a5d36; box-shadow: 0 5px 15px rgba(26, 93, 54, 0.1); }
        .pkg-name { font-weight: bold; color: #333; margin-bottom: 5px; }
        .pkg-price { color: #d32f2f; font-weight: bold; font-size: 18px; margin-bottom: 10px; }
        .pkg-desc { font-size: 13px; color: #666; margin-bottom: 15px; min-height: 40px; }
        
        .msg-success { background: #d1e7dd; color: #0f5132; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
        .msg-error { background: #f8d7da; color: #842029; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
    </style>
</head>
<body>
    <aside class="sidebar">
        <div class="logo">
            <i class="ti-bolt" style="background: white; color: #1a5d36; padding: 5px; border-radius: 50%;"></i>
            Năng Lượng
        </div>
        <ul class="nav-menu">
            <li>
                <a href="home.jsp" class="nav-item <%= request.getRequestURI().contains("home.jsp") ? "active" : "" %>">
                    <i class="ti-layout-grid2"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="forecast.jsp" class="nav-item">
                    <i class="ti-bar-chart"></i> Dự Báo
                </a>
            </li>
            <li>
                <a href="#section-register" class="nav-item">
                    <i class="ti-shopping-cart"></i> Mua Gói Điện
                </a>
            </li>
            <li><a href="#" class="nav-item"><i class="ti-settings"></i> Cài Đặt</a></li>
            <li><a href="LogoutServlet" class="nav-item"><i class="ti-power-off"></i> Đăng Xuất</a></li>
        </ul>    
    </aside>

    <main class="content">
        <%
            // Lấy User từ Session
            Users user = (Users) session.getAttribute("user"); // Đảm bảo key session đúng là "user"
            String displayName = (user != null) ? user.getName() : "Khách";
            
            // Xử lý thông báo từ OrdersServlet trả về
            String successMsg = (String) request.getAttribute("successMessage");
            String errorMsg = (String) request.getAttribute("errorMessage");
        %>

        <header class="header">
            <h2>Dashboard</h2>
            <div style="display: flex; align-items: center; gap: 10px;">
                <span>Xin chào, <strong><%= displayName %></strong></span>
                <img src="https://ui-avatars.com/api/?name=<%= displayName.replace(" ", "+") %>&background=1a5d36&color=fff" style="width: 35px; border-radius: 50%;">
            </div>
        </header>

        <% if (successMsg != null) { %> <div class="msg-success"><i class="ti-check"></i> <%= successMsg %></div> <% } %>
        <% if (errorMsg != null) { %> <div class="msg-error"><i class="ti-close"></i> <%= errorMsg %></div> <% } %>

        <div class="kpi-row">
            <div class="kpi-card">
                <div class="kpi-title">Tiêu Thụ Tháng Này</div>
                <div class="kpi-value">1,250 <small style="font-size: 12px; font-weight: normal;">kWh</small></div>
            </div>
            <div class="kpi-card">
                <div class="kpi-title">Chi Phí Ước Tính</div>
                <div class="kpi-value">2,300,000 <small style="font-size: 12px; font-weight: normal;">đ</small></div>
            </div>
            <div class="kpi-card">
                <div class="kpi-title">Nhiệt Độ Hiện Tại</div>
                <div class="kpi-value">32°C <i class="ti-sun" style="color: #f59e0b;"></i></div>
            </div>
            <div class="kpi-card">
                <div class="kpi-title">Giá Điện Hiện Tại</div>
                <div class="kpi-value">2,500 <small style="font-size: 12px; font-weight: normal;">đ/kWh</small></div>
            </div>
        </div>

        <div class="chart-row">
            <div class="chart-card">
                <h4 style="margin-bottom: 15px;">Mức Tiêu Thụ Theo Ngày</h4>
                <canvas id="lineChart" height="150"></canvas>
            </div>
            <div class="chart-card">
                <h4 style="margin-bottom: 15px;">Dự Báo Tháng Tới</h4>
                <canvas id="barChart" height="230"></canvas>
            </div>
        </div>

        <div class="info-row">
            <div class="alert-box">
                <i class="ti-alert" style="color: #f59e0b; font-size: 20px;"></i>
                <div>
                    <strong style="display: block; margin-bottom: 5px;">Cảnh Báo Bất Thường</strong>
                    <p style="font-size: 13px; color: #666;">Tiêu thụ tối qua tăng đột biến 150%! Kiểm tra lại các thiết bị.</p>
                </div>
            </div>
            <div class="tip-box">
                <i class="ti-light-bulb" style="color: #22c55e; font-size: 20px;"></i>
                <div>
                    <strong style="display: block; margin-bottom: 5px;">Gợi Ý Tiết Kiệm Điện</strong>
                    <p style="font-size: 13px; color: #666;">Hãy dùng máy giặt sau 22h để tiết kiệm chi phí điện giờ cao điểm.</p>
                </div>
            </div>
        </div>

        <div class="registration-section" id="section-register">
            <div class="reg-header">
                <i class="ti-shopping-cart-full"></i> Đăng Ký Gói Điện Mới
            </div>

            <form action="home.jsp#section-register" method="GET" class="filter-form">
                <label>Nguồn điện:</label>
                <select name="supplierType">
                    <option value="solar" <%= "solar".equals(request.getParameter("supplierType")) ? "selected" : "" %>>Năng lượng Mặt Trời</option>
                    <option value="wind" <%= "wind".equals(request.getParameter("supplierType")) ? "selected" : "" %>>Năng lượng Gió</option>
                    <option value="EVN" <%= "EVN".equals(request.getParameter("supplierType")) ? "selected" : "" %>>Điện Lưới (EVN)</option>
                </select>

                <label>Loại hình:</label>
                <select name="usageType">
                    <option value="household" <%= "household".equals(request.getParameter("usageType")) ? "selected" : "" %>>Hộ gia đình</option>
                    <option value="business" <%= "business".equals(request.getParameter("usageType")) ? "selected" : "" %>>Kinh doanh</option>
                </select>

                <button type="submit" class="btn-green">Tìm Kiếm</button>
            </form>

            <div class="packages-grid">
                <%
                    String sType = request.getParameter("supplierType");
                    String uType = request.getParameter("usageType");
                    
                    if (sType != null && uType != null) {
                        // LƯU Ý: TÊN PERSISTENCE UNIT CỦA BẠN LÀ "EnergyPU"
                        EntityManagerFactory emf = Persistence.createEntityManagerFactory("EnergyPU");
                        ServicePackagesJpaController controller = new ServicePackagesJpaController(emf);
                        
                        try {
                            List<ServicePackages> list = controller.findPackagesByFilter(sType, uType);
                            
                            if (list.isEmpty()) {
                                out.println("<p style='grid-column: 1/-1; color: red; text-align: center; margin-top: 10px;'>Không tìm thấy gói cước phù hợp.</p>");
                            }

                            for (ServicePackages p : list) {
                %>
                                <div class="package-item">
                                    <div>
                                        <div class="pkg-name"><%= p.getName() %></div>
                                        <div class="pkg-price"><%= String.format("%,.0f", p.getPrice()) %> đ</div>
                                        <div class="pkg-desc"><%= p.getDescription() %></div>
                                    </div>
                                    
                                    <a href="register_electricity.jsp?id=<%= p.getPackageId() %>" 
                                       class="btn-green" 
                                       style="display:block; text-align:center; text-decoration:none; width: 100%; margin-top: 10px;">
                                        Xem Chi Tiết
                                    </a>
                                </div>
                <%
                            }
                        } catch (Exception e) {
                             out.println("<p>Lỗi DB: " + e.getMessage() + "</p>");
                        } finally {
                            emf.close();
                        }
                    } else {
                        out.println("<p style='grid-column: 1/-1; color: #666; text-align: center; margin-top: 20px;'>Vui lòng chọn bộ lọc và nhấn Tìm Kiếm để xem các gói cước.</p>");
                    }
                %>
            </div>
        </div>

    </main>

    <script>
        // Line Chart
        const lineCtx = document.getElementById('lineChart').getContext('2d');
        new Chart(lineCtx, {
            type: 'line',
            data: {
                labels: ['00','04','08','12','16','20','24'],
                datasets: [{
                    label: 'kWh',
                    data: [5, 3, 15, 25, 20, 45, 10],
                    borderColor: '#1a5d36',
                    backgroundColor: 'rgba(26, 93, 54, 0.1)',
                    fill: true, tension: 0.4
                }]
            }
        });

        // Bar Chart
        const barCtx = document.getElementById('barChart').getContext('2d');
        new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: ['T1','T2','T3','T4','T5'],
                datasets: [{
                    label: 'Dự báo (kWh)',
                    data: [300, 450, 320, 500, 400],
                    backgroundColor: '#22c55e',
                    borderRadius: 5
                }]
            }
        });
    </script>
</body>
</html>