<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Năng Lượng - Dự Báo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Dùng chung CSS với home.jsp để đồng bộ giao diện */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #f0f2f5; display: flex; min-height: 100vh; }
        .sidebar { width: 240px; background-color: #1a5d36; color: white; padding: 25px 0; }
        .logo { display: flex; align-items: center; padding: 0 25px; margin-bottom: 40px; font-weight: bold; font-size: 20px; gap: 10px; }
        .nav-item { padding: 15px 25px; display: flex; align-items: center; gap: 15px; cursor: pointer; opacity: 0.7; }
        .nav-item.active { background: rgba(255,255,255,0.1); opacity: 1; border-left: 4px solid #fff; }
        .content { flex: 1; padding: 25px; }
        
        /* CSS riêng cho trang Dự báo */
        .forecast-container { background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .forecast-header { background: linear-gradient(to right, #2d8b4e, #4ade80); color: white; padding: 20px; font-size: 22px; font-weight: bold; }
        .filter-bar { padding: 15px 20px; border-bottom: 1px solid #eee; display: flex; gap: 10px; }
        .btn-tab { padding: 8px 15px; border-radius: 20px; border: 1px solid #ddd; background: white; cursor: pointer; }
        .btn-tab.active { background: #1a5d36; color: white; border-color: #1a5d36; }
        
        .chart-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; padding: 20px; }
        .chart-box { border: 1px solid #f0f0f0; border-radius: 10px; padding: 15px; }
        .alert-text { color: #dc2626; font-weight: bold; display: flex; align-items: center; gap: 5px; margin-top: 15px; }
    </style>
</head>
<body>
    <aside class="sidebar">
        <div class="logo"><i class="ti-bolt"></i> Năng Lượng</div>
        <ul class="nav-menu">
            <li class="nav-item"><a href="home.jsp" style="color:inherit; text-decoration:none;"><i class="ti-layout-grid2"></i> Dashboard</a></li>
            <li class="nav-item active"><i class="ti-bar-chart"></i> Dự Báo</li>
            <li class="nav-item"><i class="ti-wallet"></i> Gói Dịch Vụ</li>
            <li class="nav-item"><i class="ti-settings"></i> Cài Đặt</li>
        </ul>
    </aside>

    <main class="content">
        <div class="forecast-container">
            <div class="forecast-header">Energy Forecast</div>
            
            <div class="filter-bar">
                <button class="btn-tab">Theo Giờ</button>
                <button class="btn-tab active">Theo Ngày</button>
                <button class="btn-tab">Theo Tháng</button>
                <select style="margin-left: auto; padding: 5px 15px; border-radius: 5px;">
                    <option>Tháng 5 / 2024</option>
                </select>
            </div>

            <div class="chart-grid">
                <div class="chart-box">
                    <h4 style="color: #444; margin-bottom: 10px;">Dự Báo Tiêu Thụ Điện</h4>
                    <p style="color: #22c55e; font-size: 14px; margin-bottom: 15px;">Cao Điểm: 18:00 - 20:00</p>
                    <canvas id="predictChart"></canvas>
                    <div style="margin-top: 15px; font-weight: bold;">Dự Kiến: 2,450,000 đ</div>
                </div>

                <div class="chart-box">
                    <h4 style="color: #444; margin-bottom: 10px;">Ước Tính Chi Phí</h4>
                    <canvas id="costChart"></canvas>
                    <div class="alert-text">
                        <i class="ti-plus" style="background:red; color:white; border-radius:50%; padding:2px; font-size:10px;"></i>
                        Cảnh Báo: Vượt ngưỡng tiêu thụ!
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Line Chart - Dự báo
        const ctx1 = document.getElementById('predictChart').getContext('2d');
        new Chart(ctx1, {
            type: 'line',
            data: {
                labels: ['4.0','9.5','10.0','2.5','20.0'],
                datasets: [{
                    data: [10, 25, 15, 20, 35],
                    borderColor: '#3b82f6',
                    pointBackgroundColor: '#3b82f6',
                    fill: false, tension: 0.4
                }]
            },
            options: { plugins: { legend: { display: false } } }
        });

        // Bar Chart - Chi phí
        const ctx2 = document.getElementById('costChart').getContext('2d');
        new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: ['9:00','13:00','16:00','22:00'],
                datasets: [{
                    data: [15, 30, 60, 40],
                    backgroundColor: ['#84cc16', '#22c55e', '#22c55e', '#3b82f6'],
                    borderRadius: 5
                }]
            },
            options: { plugins: { legend: { display: false } } }
        });
    </script>
</body>
</html>