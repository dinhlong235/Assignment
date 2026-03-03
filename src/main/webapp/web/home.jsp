<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        .sidebar { width: 240px; background-color: #1a5d36; color: white; padding: 25px 0; }
        .logo { display: flex; align-items: center; padding: 0 25px; margin-bottom: 40px; font-weight: bold; font-size: 20px; gap: 10px; }
        .nav-menu { list-style: none; }
        .nav-item { padding: 15px 25px; display: flex; align-items: center; gap: 15px; cursor: pointer; opacity: 0.7; transition: 0.3s; }
        .nav-item.active { background: rgba(255,255,255,0.1); opacity: 1; border-left: 4px solid #fff; }
        .nav-item:hover { opacity: 1; background: rgba(255,255,255,0.05); }

        /* 2. MAIN CONTENT */
        .content { flex: 1; padding: 25px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        
        /* 4 Thẻ KPI */
        .kpi-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 25px; }
        .kpi-card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .kpi-title { color: #888; font-size: 13px; margin-bottom: 8px; }
        .kpi-value { font-size: 22px; font-weight: bold; color: #1a5d36; }

        /* Khu vực Biểu đồ */
        .chart-row { display: grid; grid-template-columns: 1.5fr 1fr; gap: 20px; margin-bottom: 25px; }
        .chart-card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }

        /* Ô Cảnh báo & Gợi ý */
        .info-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .alert-box { background: #fff8ee; border: 1px solid #ffe8cc; padding: 15px; border-radius: 12px; display: flex; gap: 15px; }
        .tip-box { background: #f0fdf4; border: 1px solid #dcfce7; padding: 15px; border-radius: 12px; display: flex; gap: 15px; }
    </style>
</head>
<body>
    <aside class="sidebar">
        <div class="logo">
            <i class="ti-bolt" style="background: white; color: #1a5d36; padding: 5px; border-radius: 50%;"></i>
            Năng Lượnga
        </div>
        <ul class="nav-menu" style="list-style: none;">
    <li class="nav-item <%= request.getRequestURI().contains("home.jsp") ? "active" : "" %>">
        <a href="home.jsp" style="color:inherit; text-decoration:none; display:flex; align-items:center; gap:15px; width:100%;">
            <i class="ti-layout-grid2"></i> Dashboard
        </a>
    </li>
    
    <li class="nav-item <%= request.getRequestURI().contains("forecast.jsp") ? "active" : "" %>">
        <a href="forecast.jsp" style="color:inherit; text-decoration:none; display:flex; align-items:center; gap:15px; width:100%;">
            <i class="ti-bar-chart"></i> Dự Báo
        </a>
    </li>
    
    <li class="nav-item"><i class="ti-wallet"></i> Gói Dịch Vụ</li>
    <li class="nav-item"><i class="ti-settings"></i> Cài Đặt</li>
</ul>    </aside>

    <main class="content">
        <%@page import="model.Users"%>
<%
    // Lấy đối tượng user từ session
    Users user = (Users) session.getAttribute("userSession");
    String displayName = (user != null) ? user.getName() : "Khách";
%>
        <header class="header">
            <h2>Dashboard</h2>
            <div style="display: flex; align-items: center; gap: 10px;">
                <span>Xin chào, <strong>Dan</strong></span>
                <img src="https://ui-avatars.com/api/?name=Dan&background=1a5d36&color=fff" style="width: 35px; border-radius: 50%;">
            </div>
        </header>

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