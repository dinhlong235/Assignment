<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ước tính điện năng - EVN Pro</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            /* =========================================
               1. MÀN HÌNH CHÍNH
               ========================================= */
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #1e1e1e;
                color: #ffffff;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 900px;
                margin: 0 auto;
            }
            /* =========================================
               CSS KHỐI THÔNG TIN NGƯỜI SỬ DỤNG (TRÊN CÙNG)
               ========================================= */
            .user-info-card {
                background: #ffffff; /* Nền trắng như ảnh của bạn */
                border-radius: 8px;
                padding: 20px;
                display: flex;
                align-items: center; /* Căn giữa theo chiều dọc */
                margin-bottom: 30px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                color: #333; /* Chữ đen */
            }

            .icon-section {
                width: 150px;
                text-align: center;
            }
            .user-info-icon {
                font-size: 70px;
                color: #b9d3fc;
            } /* Màu xanh nhạt giống ảnh */

            .text-section {
                flex: 1;
                text-align: center;
            }
            .text-section .title {
                font-weight: bold;
                font-size: 18px;
                color: #000;
            }

            /* Hiệu ứng biến hình cho khối dữ liệu */
            .info-details {
                display: none; /* Mặc định ẩn */
                text-align: left; /* Chữ bên trong căn trái */
                margin: 15px auto 0 auto; /* Đẩy khối này ra chính giữa */
                width: fit-content; /* Co gọn lại vừa bằng chữ */
                line-height: 1.6;
                font-size: 15px;
            }

            .btn-section {
                width: 150px;
                text-align: right;
            }
            .btn-section .btn-primary {
                background-color: #0b4b96;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
            }

            /* Chỗ hiển thị chi tiết thông tin (Mặc định ẩn) */
            .info-details {
                display: none;
                font-size: 14px;
                color: #ccc;
                line-height: 1.6;
            }
            .btn-primary {
                background-color: #155e9c;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
            }
            .section-title {
                text-align: center;
                font-weight: bold;
                color: #e0e0e0;
                margin: 20px 0;
                font-size: 1.1em;
            }
            .grid-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 30px;
            }

            .device-item {
                background: #252525;
                border: 1px solid #333;
                border-radius: 6px;
                padding: 15px 20px;
                display: flex;
                align-items: center;
                cursor: pointer;
                transition: 0.3s;
            }
            .device-item:hover {
                background: #303030;
            }
            .device-icon {
                font-size: 20px;
                color: #6ba4ff;
                width: 40px;
            }
            .device-name {
                flex-grow: 1;
                font-weight: 500;
                color: #e0e0e0;
            }
            .device-arrow {
                color: #888;
            }

            .device-item.active {
                background-color: #155e9c;
                border-color: #155e9c;
            }
            .device-item.active .device-icon, .device-item.active .device-name, .device-item.active .device-arrow {
                color: white;
            }

            /* =========================================
               2. POPUP MODAL CHUNG
               ========================================= */
            .modal-container {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.7);
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }
            .modal-content {
                background: #1e1e1e;
                width: 100%;
                height: 100%;
                text-align: center;
                position: relative;
                box-sizing: border-box;
                overflow-y: auto;
                color: #ffffff;
                padding-bottom: 50px;
            }
            .modal-header {
                padding: 30px 20px 10px;
                position: relative;
            }
            .modal-header h2 {
                margin: 0;
                font-weight: 500;
                font-size: 24px;
                color: #fff;
            }
            .close-btn {
                position: absolute;
                right: 20px;
                top: 15px;
                font-size: 30px;
                color: #888;
                cursor: pointer;
            }
            .close-btn:hover {
                color: #fff;
            }
            .modal-subtitle {
                margin-bottom: 30px;
                font-size: 16px;
                color: #ccc;
                font-weight: 500;
            }

            /* KHỐI VUÔNG BẾP, ĐÈN, MÁY GIẶT */
            .type-selector {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }
            .type-card {
                width: 150px;
                height: 140px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                cursor: pointer;
                transition: 0.3s;
                border-radius: 8px;
                border: 2px solid transparent;
                position: relative;
            }
            .type-card .check-icon {
                display: none;
                position: absolute;
                top: 10px;
                right: 10px;
                color: white;
                font-size: 20px;
            }
            .type-card.inactive {
                background-color: #252525;
                color: #6ba4ff;
                border: 1px solid #444;
            }
            .type-card.active {
                background-color: #0b4b96;
                color: white;
                border: 2px solid #6ba4ff;
                box-shadow: 0 0 15px rgba(107, 164, 255, 0.3);
            }
            .type-card.active .check-icon {
                display: block;
            }
            .type-card i.main-icon {
                font-size: 40px;
                margin-bottom: 15px;
            }
            .type-card span {
                font-weight: bold;
                font-size: 14px;
                text-align: center;
            }

            /* INPUT SỐ LƯỢNG / GIỜ DÙNG CHUNG */
            .selected-rows-container {
                display: flex;
                flex-direction: column;
                gap: 15px;
                max-width: 600px;
                margin: 0 auto 40px auto;
            }
            .device-row {
                display: none;
                flex-direction: column;
                background: #2a2a2a;
                padding: 15px 20px;
                border-radius: 8px;
                border: 1px solid #444;
                border-left: 4px solid #f39c12;
            }
            .row-title {
                text-align: left;
                font-weight: bold;
                color: #6ba4ff;
                font-size: 16px;
                margin-bottom: 15px;
                border-bottom: 1px solid #444;
                padding-bottom: 5px;
            }
            .controls-wrapper {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                gap: 15px;
            }
            .input-group {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 15px;
                color: #ccc;
            }
            .number-control {
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .number-control input {
                width: 50px;
                height: 35px;
                border: 1px solid #555;
                border-radius: 6px;
                text-align: center;
                font-size: 18px;
                outline: none;
                background: #1e1e1e;
                color: #fff;
                font-weight: bold;
            }
            .btn-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
            .action-icon {
                color: #f39c12;
                cursor: pointer;
                font-size: 20px;
                transition: 0.1s;
            }
            .action-icon:active {
                transform: scale(0.9);
            }

            .confirm-btn {
                background-color: #f39c12;
                color: #111;
                font-weight: bold;
                border: none;
                padding: 12px 70px;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: 0.3s;
                margin-top: 20px;
            }
            .confirm-btn:hover {
                background-color: #e67e22;
                color: white;
            }

            /* =========================================
               3. CSS RIÊNG CHO TỦ LẠNH
               ========================================= */
            .fridge-layout {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 30px;
                max-width: 900px;
                margin: 0 auto 40px auto;
            }
            .fridge-row {
                display: flex;
                justify-content: center;
                gap: 20px;
                width: 100%;
                flex-wrap: wrap;
            }
            .fridge-wrapper {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 150px;
            }
            .static-card {
                background-color: #252525;
                color: #6ba4ff;
                border: 1px solid #444;
                width: 100%;
                height: 130px;
                border-radius: 8px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                margin-bottom: 10px;
            }
            .static-card i.main-icon {
                font-size: 40px;
                margin-bottom: 15px;
            }
            .static-card span {
                font-weight: bold;
                font-size: 14px;
                text-align: center;
            }
            .fridge-controls {
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .fridge-controls input {
                width: 55px;
                height: 35px;
                border: 1px solid #555;
                border-radius: 6px;
                text-align: center;
                font-size: 18px;
                outline: none;
                background: #1e1e1e;
                color: #fff;
                font-weight: bold;
            }

            /* =========================================
               4. CSS MÁY RỬA BÁT (SLIDER DỌC)
               ========================================= */
            .mrb-header-area {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
                margin-bottom: 40px;
            }
            .mrb-header-area span {
                font-size: 18px;
                color: #e0e0e0;
            }
            .value-badge {
                background: white;
                color: #1e1e1e;
                font-size: 20px;
                font-weight: bold;
                padding: 5px 20px;
                border-radius: 6px;
                border: 2px solid #ccc;
            }
            .range-wrapper {
                height: 280px;
                width: 60px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 50px auto;
            }
            .vertical-range {
                transform: rotate(270deg);
                width: 250px;
                -webkit-appearance: none;
                background: transparent;
            }
            .vertical-range:focus {
                outline: none;
            }
            .vertical-range::-webkit-slider-runnable-track {
                width: 100%;
                height: 24px;
                cursor: pointer;
                border-radius: 4px;
                border: 2px solid #000000;
                background: repeating-linear-gradient(90deg, transparent, transparent 6px, #1e1e1e 6px, #1e1e1e 9px), linear-gradient(90deg, #1b3bb8 0%, #d63384 100%);
            }
            .vertical-range::-webkit-slider-thumb {
                height: 42px;
                width: 42px;
                border-radius: 50%;
                background: radial-gradient(circle, #8b9dc3 0%, #4a66a0 100%);
                cursor: pointer;
                -webkit-appearance: none;
                margin-top: -11px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.6);
                border: 6px solid #ffffff;
            }
            /* =========================================
               5. CSS MÀN HÌNH "THIẾT BỊ KHÁC" (BẢNG DANH SÁCH)
               ========================================= */
            .modal-content-wide {
                background: #1e1e1e;
                width: 100%;
                height: 100%;
                max-width: 1100px; /* Bảng rộng hơn popup thường */
                text-align: center;
                position: relative;
                box-sizing: border-box;
                overflow-y: auto;
                color: #ffffff;
                padding: 20px;
            }
            .tbk-table-container {
                width: 100%;
                overflow-x: auto;
                margin-bottom: 40px;
                border-radius: 8px;
                border: 1px solid #444;
            }

            .device-table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
                min-width: 700px;
            }
            .device-table th {
                background-color: #0b4b96;
                color: white;
                padding: 15px 10px;
                font-size: 16px;
                border-bottom: 2px solid #155e9c;
            }
            .device-table td {
                padding: 10px;
                border-bottom: 1px solid #333;
                background-color: #252525;
            }
            .device-table tr:hover td {
                background-color: #2c2c2c;
            } /* Hiệu ứng hover từng dòng */

            .device-table td.name-col {
                text-align: left;
                padding-left: 20px;
                font-weight: bold;
                color: #6ba4ff;
            }

            /* Ô input trong bảng */
            .table-input {
                width: 80px;
                height: 35px;
                border: 1px solid #555;
                border-radius: 4px;
                text-align: center;
                font-size: 16px;
                outline: none;
                background: #1e1e1e;
                color: #fff;
                transition: 0.3s;
            }
            .table-input:focus {
                border-color: #f39c12;
                box-shadow: 0 0 5px rgba(243, 156, 18, 0.5);
            }
            /* =========================================
               6. CSS MÀN HÌNH "NHẬP THÔNG TIN"
               ========================================= */
            #info-screen {
                display: none; /* Mặc định ẩn, chỉ hiện khi bấm nút Nhập thông tin */
                background-color: #f4f6f9; /* Nền xám sáng như video */
                color: #333; /* Chữ đen */
                padding: 30px;
                border-radius: 8px;
                max-width: 1000px;
                margin: 0 auto;
            }

            .info-header {
                text-align: center;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 30px;
                color: #155e9c;
            }

            /* 4 ô input (Họ tên, SĐT, Email, Mã KH) */
            .info-input-grid {
                display: grid;
                grid-template-columns: 1fr 1fr 1fr 1fr;
                gap: 15px;
                margin-bottom: 30px;
            }
            .info-input-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
            .info-input-group label {
                font-size: 14px;
                font-weight: bold;
                color: #555;
            }
            .info-input-group input {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                outline: none;
                font-size: 14px;
            }

            .section-divider {
                text-align: center;
                margin: 30px 0;
                position: relative;
            }
            .section-divider i {
                background-color: #f4f6f9;
                padding: 0 10px;
                color: #ccc;
                position: relative;
                z-index: 1;
            }
            .section-divider::before {
                content: "";
                position: absolute;
                top: 50%;
                left: 0;
                width: 100%;
                height: 1px;
                background-color: #ddd;
                z-index: 0;
            }

            .choose-home-title {
                text-align: center;
                color: #555;
                margin-bottom: 20px;
            }

            /* Chọn loại nhà */
            .home-type-selector {
                display: flex;
                justify-content: center;
                gap: 50px;
                margin-bottom: 30px;
            }
            .home-type-card {
                width: 150px;
                height: 120px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                border: 2px solid transparent;
                border-radius: 8px;
                cursor: pointer;
                transition: 0.3s;
                opacity: 0.5;
            }
            .home-type-card.active {
                border-color: #155e9c;
                opacity: 1;
            }
            .home-type-card i {
                font-size: 40px;
                margin-bottom: 10px;
                color: #555;
            }
            .home-type-card.active i {
                color: #155e9c;
            }
            .home-type-card span {
                font-weight: bold;
                color: #555;
            }

            /* Khu vực hiển thị ảnh minh họa và chỉnh số phòng/người */
            .home-details-container {
                display: flex;
                align-items: center;
                gap: 30px;
                margin-bottom: 30px;
            }

            .home-image-area {
                flex: 1;
                height: 300px;
                border: 1px solid #ccc;
                border-radius: 8px;
                background-color: #fff;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
            }
            .home-image-area img {
                max-width: 100%;
                max-height: 100%;
                display: none;
            } /* Ẩn ảnh ban đầu */

            .home-controls-area {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 30px;
            }

            .control-row-title {
                text-align: center;
                color: #555;
                margin-bottom: 15px;
            }
            .control-row {
                display: flex;
                justify-content: center;
                gap: 30px;
            }
            .control-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }
            .control-box .number-display {
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px 20px;
                font-size: 20px;
                font-weight: bold;
                background: white;
            }
            .control-box .label {
                color: #555;
                font-size: 14px;
            }
            .control-box .btn-group {
                display: flex;
                gap: 10px;
            }
            .control-box .btn-group i {
                color: #f39c12;
                font-size: 24px;
                cursor: pointer;
            }

            /* Chọn Tỉnh/TP */
            .city-selector {
                margin-bottom: 40px;
            }
            .city-selector select {
                width: 100%;
                padding: 12px;
                border: 1px solid #155e9c;
                border-radius: 4px;
                outline: none;
                font-size: 16px;
                background-color: #e6f0fa;
                color: #333;
            }

            .save-info-btn {
                display: block;
                margin: 0 auto;
                background-color: #f39c12;
                color: #333;
                font-weight: bold;
                border: none;
                padding: 12px 50px;
                border-radius: 25px;
                font-size: 16px;
                cursor: pointer;
                transition: 0.3s;
            }
            .save-info-btn:hover {
                background-color: #e67e22;
                color: white;
            }
            /* --- BỔ SUNG CSS CHO KẾT QUẢ THẺ THIẾT BỊ --- */
            .device-item {
                position: relative; /* Thêm dòng này để căn chỉnh khối xanh */
                overflow: hidden;   /* Cắt phần khối xanh bị thừa ra ngoài góc bo tròn */
            }
            .device-name-container {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }
            .device-subtext {
                font-size: 12px;
                color: #6ba4ff;
                margin-top: 4px;
                display: none; /* Mặc định ẩn */
            }
            .device-result-box {
                position: absolute;
                right: 0;
                top: 0;
                bottom: 0;
                width: 70px;
                background-color: #155e9c;
                color: white;
                display: none; /* Mặc định ẩn */
                flex-direction: column;
                justify-content: center;
                align-items: center;
                box-shadow: -2px 0 5px rgba(0,0,0,0.2);
            }
            .box-num {
                font-size: 22px;
                font-weight: bold;
            }
            .box-unit {
                font-size: 11px;
            }
        </style>
    </head>
    <body>

        <div class="container" id="main-screen">
            <div class="user-info-card">
                <div class="icon-section">
                    <i class="fa-solid fa-users user-info-icon"></i>
                </div>

                <div class="text-section">
                    <div class="title">Thông tin người sử dụng điện</div>
                    <div class="info-details" id="info-details-area">
                        Họ tên: <span id="disp-name"></span><br>
                        Số điện thoại: <span id="disp-phone"></span><br>
                        Email: <span id="disp-email"></span><br>
                        Địa chỉ: <span id="disp-city"></span><br>
                        <span id="disp-home"></span>
                    </div>
                </div>

                <div class="btn-section">
                    <button class="btn-primary" onclick="openInfoScreen()">Nhập thông tin</button>
                </div>
            </div>

            <div class="section-title">Thiết bị cơ bản</div>
            <div class="grid-container">
                <div class="device-item" id="item-bep" onclick="openDeviceModal('bepModal', 'item-bep')">
                    <i class="fa-solid fa-fire-burner device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Bếp điện</span>
                        <span class="device-subtext" id="subtext-item-bep">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-bep">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-bep">
                        <span class="box-num" id="val-box-item-bep">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-bep"></i>
                </div>

                <div class="device-item" id="item-den" onclick="openDeviceModal('denModal', 'item-den')">
                    <i class="fa-regular fa-lightbulb device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Đèn chiếu sáng</span>
                        <span class="device-subtext" id="subtext-item-den">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-den">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-den">
                        <span class="box-num" id="val-box-item-den">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-den"></i>
                </div>

                <div class="device-item" id="item-tu-lanh" onclick="openDeviceModal('tuLanhModal', 'item-tu-lanh')">
                    <i class="fa-solid fa-icicles device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Tủ lạnh</span>
                        <span class="device-subtext" id="subtext-item-tu-lanh">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-tu-lanh">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-tu-lanh">
                        <span class="box-num" id="val-box-item-tu-lanh">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-tu-lanh"></i>
                </div>

                <div class="device-item" id="item-mrb" onclick="openDeviceModal('mrbModal', 'item-mrb')">
                    <i class="fa-solid fa-sink device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Máy rửa bát</span>
                        <span class="device-subtext" id="subtext-item-mrb">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-mrb">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-mrb">
                        <span class="box-num" id="val-box-item-mrb">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-mrb"></i>
                </div>

                <div class="device-item" id="item-mg" onclick="openDeviceModal('mgModal', 'item-mg')">
                    <i class="fa-solid fa-shirt device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Máy giặt</span>
                        <span class="device-subtext" id="subtext-item-mg">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-mg">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-mg">
                        <span class="box-num" id="val-box-item-mg">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-mg"></i>
                </div>

                <div class="device-item" id="item-tbk" onclick="openDeviceModal('tbkModal', 'item-tbk')">
                    <i class="fa-solid fa-fan device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Thiết bị khác</span>
                        <span class="device-subtext" id="subtext-item-tbk">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-tbk">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-tbk">
                        <span class="box-num" id="val-box-item-tbk">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-tbk"></i>
                </div>
            </div>
            <div class="section-title">Thiết bị tiêu thụ nhiều điện</div>
            <div class="grid-container">
                <div class="device-item" id="item-dieu-hoa" onclick="checkHeavyDevice('dhModal', 'item-dieu-hoa')">
                    <i class="fa-solid fa-snowflake device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Điều hòa</span>
                        <span class="device-subtext" id="subtext-item-dieu-hoa">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-dieu-hoa">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-dieu-hoa">
                        <span class="box-num" id="val-box-item-dieu-hoa">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-dieu-hoa"></i>
                </div>

                <div class="device-item" id="item-may-say" onclick="checkHeavyDevice('msModal', 'item-may-say')">
                    <i class="fa-solid fa-shirt device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Máy sấy quần áo</span>
                        <span class="device-subtext" id="subtext-item-may-say">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-may-say">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-may-say">
                        <span class="box-num" id="val-box-item-may-say">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-may-say"></i>
                </div>

                <div class="device-item" id="item-binh-nong" onclick="checkHeavyDevice('bnModal', 'item-binh-nong')">
                    <i class="fa-solid fa-temperature-arrow-up device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Bình nóng lạnh</span>
                        <span class="device-subtext" id="subtext-item-binh-nong">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-binh-nong">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-binh-nong">
                        <span class="box-num" id="val-box-item-binh-nong">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-binh-nong"></i>
                </div>

                <div class="device-item" id="item-lo-nuong" onclick="checkHeavyDevice('lnModal', 'item-lo-nuong')">
                    <i class="fa-solid fa-kitchen-set device-icon"></i>
                    <div class="device-name-container">
                        <span class="device-name">Lò nướng</span>
                        <span class="device-subtext" id="subtext-item-lo-nuong">Điện tiêu thụ tháng 03/2026 là <span id="val-sub-item-lo-nuong">0</span> kWh!</span>
                    </div>
                    <div class="device-result-box" id="box-item-lo-nuong">
                        <span class="box-num" id="val-box-item-lo-nuong">0</span>
                        <span class="box-unit">kWh</span>
                    </div>
                    <i class="fa-solid fa-chevron-right device-arrow" id="arrow-item-lo-nuong"></i>
                </div>
            </div>
        </div>
        <div id="info-screen">
            <div class="info-header">NHẬP THÔNG TIN KHÁCH HÀNG SỬ DỤNG ĐIỆN</div>

            <div class="info-input-grid">
                <div class="info-input-group"><label>Họ tên</label><input type="text" id="info-name" placeholder="Nhập họ tên"></div>
                <div class="info-input-group"><label>Số điện thoại</label><input type="text" id="info-phone" placeholder="Nhập số điện thoại"></div>
                <div class="info-input-group"><label>Email</label><input type="text" id="info-email" placeholder="Nhập Email"></div>
                <div class="info-input-group"><label>Mã khách hàng</label><input type="text" id="info-code" placeholder="Nhập mã khách hàng"></div>
            </div>

            <div class="section-divider"><i class="fa-solid fa-plus"></i></div>
            <div class="choose-home-title">Chọn nhà của bạn</div>

            <div class="home-type-selector">
                <div class="home-type-card active" id="type-nha-rieng" onclick="selectHomeType('nha-rieng')">
                    <i class="fa-solid fa-house"></i><span>Nhà riêng</span>
                </div>
                <div class="home-type-card" id="type-chung-cu" onclick="selectHomeType('chung-cu')">
                    <i class="fa-solid fa-building"></i><span>Chung cư</span>
                </div>
            </div>

            <div class="home-details-container">
                <div class="home-image-area">
                    <i class="fa-solid fa-house" id="img-nha-rieng" style="font-size: 150px; color: #155e9c; display: block;"></i>
                    <i class="fa-solid fa-building" id="img-chung-cu" style="font-size: 150px; color: #155e9c; display: none;"></i>
                </div>

                <div class="home-controls-area">
                    <div>
                        <div class="control-row-title">Chọn số lượng phòng</div>
                        <div class="control-row">
                            <div class="control-box">
                                <div class="number-display" id="qty-phong-ngu">1</div>
                                <div class="btn-group">
                                    <i class="fa-solid fa-circle-plus" onclick="changeInfoQty('phong-ngu', 1)"></i>
                                    <i class="fa-solid fa-circle-minus" onclick="changeInfoQty('phong-ngu', -1)"></i>
                                </div>
                                <div class="label">Phòng ngủ</div>
                            </div>
                            <div class="control-box">
                                <div class="number-display" id="qty-phong-tam">1</div>
                                <div class="btn-group">
                                    <i class="fa-solid fa-circle-plus" onclick="changeInfoQty('phong-tam', 1)"></i>
                                    <i class="fa-solid fa-circle-minus" onclick="changeInfoQty('phong-tam', -1)"></i>
                                </div>
                                <div class="label">Phòng tắm</div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="control-row-title">Chọn số lượng người</div>
                        <div class="control-row">
                            <div class="control-box">
                                <div class="number-display" id="qty-nguoi-lon">1</div>
                                <div class="btn-group">
                                    <i class="fa-solid fa-circle-plus" onclick="changeInfoQty('nguoi-lon', 1)"></i>
                                    <i class="fa-solid fa-circle-minus" onclick="changeInfoQty('nguoi-lon', -1)"></i>
                                </div>
                                <div class="label">Người lớn</div>
                            </div>
                            <div class="control-box">
                                <div class="number-display" id="qty-tre-em">0</div>
                                <div class="btn-group">
                                    <i class="fa-solid fa-circle-plus" onclick="changeInfoQty('tre-em', 1)"></i>
                                    <i class="fa-solid fa-circle-minus" onclick="changeInfoQty('tre-em', -1)"></i>
                                </div>
                                <div class="label">Trẻ em</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="city-selector">
                <div style="font-size: 14px; color: #155e9c; font-weight: bold; margin-bottom: 5px;">Khu vực (Tỉnh/TP) bạn đang ở?</div>
                <select id="city-select">
                    <option value="Hà Nội">Hà Nội</option>
                    <option value="TP Hồ Chí Minh">TP Hồ Chí Minh</option>
                    <option value="Đà Nẵng">Đà Nẵng</option>
                    <option value="Khác">Tỉnh/Thành phố khác...</option>
                </select>
            </div>

            <button class="save-info-btn" onclick="saveCustomerInfo()">Lưu thông tin</button>
        </div>
        <div id="bepModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('bepModal')">&times;</span>
                <div class="modal-header"><h2>Bếp điện</h2></div>
                <p class="modal-subtitle">Chọn loại bếp điện bạn có ?</p>
                <div class="type-selector">
                    <div class="type-card inactive" id="card-don" onclick="toggleSelection('don')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-regular fa-square main-icon"></i><span>Bếp đơn</span>
                    </div>
                    <div class="type-card inactive" id="card-doi" onclick="toggleSelection('doi')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-table-cells-large main-icon"></i><span>Bếp đôi</span>
                    </div>
                </div>
                <div class="selected-rows-container">
                    <div class="device-row" id="row-don"><div class="row-title">Thông số: Bếp đơn</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-don" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('don', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('don', 'hours', -0.5)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-don" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('don', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('don', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-doi"><div class="row-title">Thông số: Bếp đôi</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-doi" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('doi', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('doi', 'hours', -0.5)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-doi" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('doi', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('doi', 'qty', -1)"></i></div></div></div></div></div>
                </div>
                <button class="confirm-btn" onclick="submitData('Bếp Điện')">Xác nhận</button>
            </div>
        </div>

        <div id="denModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('denModal')">&times;</span>
                <div class="modal-header"><h2>Đèn chiếu sáng</h2></div>
                <p class="modal-subtitle">Chọn loại đèn chiếu sáng bạn có ?</p>
                <div class="type-selector">
                    <div class="type-card inactive" id="card-hq" onclick="toggleSelection('hq')"><i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-lightbulb main-icon"></i><span>Đèn huỳnh quang</span></div>
                    <div class="type-card inactive" id="card-led" onclick="toggleSelection('led')"><i class="fa-solid fa-circle-check check-icon"></i><i class="fa-regular fa-lightbulb main-icon"></i><span>Đèn LED</span></div>
                    <div class="type-card inactive" id="card-sd" onclick="toggleSelection('sd')"><i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-sun main-icon"></i><span>Đèn sợi đốt</span></div>
                    <div class="type-card inactive" id="card-ha" onclick="toggleSelection('ha')"><i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-certificate main-icon"></i><span>Đèn Halogen</span></div>
                </div>
                <div class="selected-rows-container">
                    <div class="device-row" id="row-hq"><div class="row-title">Đèn huỳnh quang</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-hq" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('hq', 'hours', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('hq', 'hours', -1)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-hq" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('hq', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('hq', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-led"><div class="row-title">Đèn LED</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-led" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('led', 'hours', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('led', 'hours', -1)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-led" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('led', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('led', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-sd"><div class="row-title">Đèn sợi đốt</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-sd" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('sd', 'hours', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('sd', 'hours', -1)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-sd" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('sd', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('sd', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-ha"><div class="row-title">Đèn Halogen</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-ha" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ha', 'hours', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ha', 'hours', -1)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-ha" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ha', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ha', 'qty', -1)"></i></div></div></div></div></div>
                </div>
                <button class="confirm-btn" onclick="submitData('Đèn Chiếu Sáng')">Xác nhận</button>
            </div>
        </div>

        <div id="tuLanhModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('tuLanhModal')">&times;</span>
                <div class="modal-header"><h2>Tủ lạnh</h2></div>
                <p class="modal-subtitle">Số lượng mỗi loại tủ lạnh của bạn</p>
                <div class="fridge-layout">
                    <div class="fridge-row">
                        <div class="fridge-wrapper"><div class="static-card"><i class="fa-solid fa-snowflake main-icon"></i><span>Mini</span></div><div class="fridge-controls"><input type="number" id="qty-mini" value="0" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeFridgeQty('mini', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeFridgeQty('mini', -1)"></i></div></div></div>
                        <div class="fridge-wrapper"><div class="static-card"><i class="fa-solid fa-box main-icon"></i><span>Trung bình</span></div><div class="fridge-controls"><input type="number" id="qty-tb" value="0" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeFridgeQty('tb', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeFridgeQty('tb', -1)"></i></div></div></div>
                        <div class="fridge-wrapper"><div class="static-card"><i class="fa-solid fa-box-open main-icon"></i><span>Lớn</span></div><div class="fridge-controls"><input type="number" id="qty-lon" value="0" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeFridgeQty('lon', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeFridgeQty('lon', -1)"></i></div></div></div>
                        <div class="fridge-wrapper"><div class="static-card"><i class="fa-solid fa-door-closed main-icon"></i><span>Cực lớn</span></div><div class="fridge-controls"><input type="number" id="qty-cl" value="0" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeFridgeQty('cl', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeFridgeQty('cl', -1)"></i></div></div></div>
                    </div>
                    <div class="fridge-row">
                        <div class="fridge-wrapper"><div class="static-card"><i class="fa-solid fa-ice-cream main-icon"></i><span>Tủ đông</span></div><div class="fridge-controls"><input type="number" id="qty-dong" value="0" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeFridgeQty('dong', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeFridgeQty('dong', -1)"></i></div></div></div>
                    </div>
                </div>
                <button class="confirm-btn" onclick="submitFridgeData()">Xác nhận</button>
            </div>
        </div>

        <div id="mgModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('mgModal')">&times;</span>
                <div class="modal-header"><h2>Máy giặt</h2></div>
                <p class="modal-subtitle">Chọn loại máy giặt bạn có ?</p>

                <div class="type-selector">
                    <div class="type-card inactive" id="card-mg-dung" onclick="toggleSelection('mg-dung')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-soap main-icon"></i><span>Máy giặt cửa đứng</span>
                    </div>
                    <div class="type-card inactive" id="card-mg-ngang" onclick="toggleSelection('mg-ngang')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-jug-detergent main-icon"></i><span>Máy giặt cửa ngang</span>
                    </div>
                </div>

                <div class="selected-rows-container">
                    <div class="device-row" id="row-mg-dung"><div class="row-title">Thông số: Cửa đứng</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-mg-dung" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('mg-dung', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('mg-dung', 'hours', -0.5)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-mg-dung" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('mg-dung', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('mg-dung', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-mg-ngang"><div class="row-title">Thông số: Cửa ngang</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-mg-ngang" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('mg-ngang', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('mg-ngang', 'hours', -0.5)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-mg-ngang" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('mg-ngang', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('mg-ngang', 'qty', -1)"></i></div></div></div></div></div>
                </div>
                <button class="confirm-btn" onclick="submitData('Máy Giặt')">Xác nhận</button>
            </div>
        </div>

        <div id="mrbModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('mrbModal')">&times;</span>
                <div class="modal-header"><h2>Máy rửa bát</h2></div>

                <div class="mrb-header-area">
                    <span>Số lần sử dụng mỗi tuần</span>
                    <div class="value-badge" id="mrb-badge">0</div>
                </div>
                <div class="range-wrapper">
                    <input type="range" class="vertical-range" id="mrb-slider" min="0" max="28" value="0" oninput="updateMrbValue(this.value)">
                </div>
                <button class="confirm-btn" onclick="submitMrbData()">Xác nhận</button>
            </div>
        </div>
        <div id="tbkModal" class="modal-container">
            <div class="modal-content-wide">
                <span class="close-btn" onclick="closeDeviceModal('tbkModal')">&times;</span>
                <div class="modal-header"><h2>Thiết bị khác</h2></div>
                <p class="modal-subtitle">Chọn các loại thiết bị khác bạn có ?</p>

                <div class="tbk-table-container">
                    <table class="device-table" id="tbk-table">
                        <thead>
                            <tr>
                                <th>Tên thiết bị</th>
                                <th>Số giờ sử dụng/ ngày</th>
                                <th>Số lượng</th>
                                <th>Công suất(W)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="tbk-row">
                                <td class="name-col">Máy phát nhạc DVD</td>
                                <td><input type="number" class="table-input hours-input" value="5.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="1" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="16" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Máy trả lời điện thoại tự động</td>
                                <td><input type="number" class="table-input hours-input" value="0.15" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="24" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Máy chiếu - Projection</td>
                                <td><input type="number" class="table-input hours-input" value="5.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="225" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Ti vi LCD</td>
                                <td><input type="number" class="table-input hours-input" value="5.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="1" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="150" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Ti vi Plasma</td>
                                <td><input type="number" class="table-input hours-input" value="5.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="300" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Máy chơi game</td>
                                <td><input type="number" class="table-input hours-input" value="5.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="20" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Máy tính để bàn</td>
                                <td><input type="number" class="table-input hours-input" value="5.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="200" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Máy tính xách tay</td>
                                <td><input type="number" class="table-input hours-input" value="6.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="1" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="50" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Thiết bị mạng (Router, DSL, Wifi,...)</td>
                                <td><input type="number" class="table-input hours-input" value="24.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="1" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="6" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Máy bơm nước</td>
                                <td><input type="number" class="table-input hours-input" value="1.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="1" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="250" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Lò vi sóng</td>
                                <td><input type="number" class="table-input hours-input" value="0.50" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="1000" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Máy sấy tóc</td>
                                <td><input type="number" class="table-input hours-input" value="0.17" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="710" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Bàn là điện</td>
                                <td><input type="number" class="table-input hours-input" value="0.25" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="0" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="1100" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Nồi cơm điện</td>
                                <td><input type="number" class="table-input hours-input" value="1.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="1" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="500" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Quạt hút bếp</td>
                                <td><input type="number" class="table-input hours-input" value="1.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="1" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="250" min="0"></td>
                            </tr>
                            <tr class="tbk-row">
                                <td class="name-col">Quạt hút mùi nhà vệ sinh</td>
                                <td><input type="number" class="table-input hours-input" value="2.00" step="0.01" min="0"></td>
                                <td><input type="number" class="table-input qty-input" value="2" min="0"></td>
                                <td><input type="number" class="table-input power-input" value="15" min="0"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <button class="confirm-btn" onclick="submitTBKData()">Xác nhận</button>
            </div>
        </div>
        <div id="dhModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('dhModal')">&times;</span>
                <div class="modal-header"><h2>Điều hòa</h2></div>
                <p class="modal-subtitle">Chọn loại điều hòa bạn có ?</p>

                <div class="type-selector">
                    <div class="type-card inactive" id="card-dh-am-tran" onclick="toggleSelection('dh-am-tran')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-fan main-icon"></i><span>Điều hòa âm trần</span>
                    </div>
                    <div class="type-card inactive" id="card-dh-tuong" onclick="toggleSelection('dh-tuong')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-wind main-icon"></i><span>Điều hòa tường</span>
                    </div>
                    <div class="type-card inactive" id="card-dh-cay" onclick="toggleSelection('dh-cay')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-server main-icon"></i><span>Điều hòa cây</span>
                    </div>
                </div>

                <div class="selected-rows-container">
                    <div class="device-row" id="row-dh-am-tran"><div class="row-title">Thông số: Âm trần</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-dh-am-tran" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('dh-am-tran', 'hours', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('dh-am-tran', 'hours', -1)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-dh-am-tran" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('dh-am-tran', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('dh-am-tran', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-dh-tuong"><div class="row-title">Thông số: Treo tường</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-dh-tuong" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('dh-tuong', 'hours', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('dh-tuong', 'hours', -1)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-dh-tuong" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('dh-tuong', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('dh-tuong', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-dh-cay"><div class="row-title">Thông số: Điều hòa cây</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-dh-cay" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('dh-cay', 'hours', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('dh-cay', 'hours', -1)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-dh-cay" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('dh-cay', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('dh-cay', 'qty', -1)"></i></div></div></div></div></div>
                </div>
                <button class="confirm-btn" onclick="submitData('Điều hòa')">Xác nhận</button>
            </div>
        </div>
        <div id="msModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('msModal')">&times;</span>
                <div class="modal-header"><h2>Máy sấy</h2></div>
                <p class="modal-subtitle">Chọn loại máy sấy bạn có ?</p>

                <div class="type-selector">
                    <div class="type-card inactive" id="card-ms-quan-ao" onclick="toggleSelection('ms-quan-ao')">
                        <i class="fa-solid fa-circle-check check-icon"></i>
                        <i class="fa-solid fa-shirt main-icon"></i>
                        <span>Máy sấy quần áo</span>
                    </div>
                </div>

                <div class="arrow-down"><i class="fa-solid fa-arrow-down"></i></div>

                <div class="selected-rows-container">
                    <div class="device-row" id="row-ms-quan-ao">
                        <div class="row-title">Thông số: Máy sấy quần áo</div>
                        <div class="controls-wrapper">
                            <div class="input-group">
                                <label>Số giờ/ngày</label>
                                <div class="number-control">
                                    <input type="number" id="hours-ms-quan-ao" readonly>
                                    <div class="btn-group">
                                        <i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ms-quan-ao', 'hours', 0.5)"></i>
                                        <i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ms-quan-ao', 'hours', -0.5)"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group">
                                <label>Số lượng</label>
                                <div class="number-control">
                                    <input type="number" id="qty-ms-quan-ao" readonly>
                                    <div class="btn-group">
                                        <i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ms-quan-ao', 'qty', 1)"></i>
                                        <i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ms-quan-ao', 'qty', -1)"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="confirm-btn" onclick="submitData('Máy Sấy')">Xác nhận</button>
            </div>
        </div>
        <div id="bnModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('bnModal')">&times;</span>
                <div class="modal-header"><h2>Bình nóng lạnh</h2></div>
                <p class="modal-subtitle">Chọn loại bình nóng lạnh bạn có ?</p>

                <div class="type-selector">
                    <div class="type-card inactive" id="card-bn-15l" onclick="toggleSelection('bn-15l')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-hot-tub-person main-icon"></i><span>Bình 15 lít</span>
                    </div>
                    <div class="type-card inactive" id="card-bn-20l" onclick="toggleSelection('bn-20l')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-temperature-high main-icon"></i><span>Bình 20 lít</span>
                    </div>
                    <div class="type-card inactive" id="card-bn-30l" onclick="toggleSelection('bn-30l')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-faucet-bubble main-icon"></i><span>Bình 30 lít</span>
                    </div>
                </div>

                <div class="selected-rows-container">
                    <div class="device-row" id="row-bn-15l"><div class="row-title">Thông số: Bình 15 lít</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-bn-15l" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('bn-15l', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('bn-15l', 'hours', -0.5)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-bn-15l" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('bn-15l', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('bn-15l', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-bn-20l"><div class="row-title">Thông số: Bình 20 lít</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-bn-20l" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('bn-20l', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('bn-20l', 'hours', -0.5)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-bn-20l" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('bn-20l', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('bn-20l', 'qty', -1)"></i></div></div></div></div></div>
                    <div class="device-row" id="row-bn-30l"><div class="row-title">Thông số: Bình 30 lít</div><div class="controls-wrapper"><div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-bn-30l" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('bn-30l', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('bn-30l', 'hours', -0.5)"></i></div></div></div><div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-bn-30l" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('bn-30l', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('bn-30l', 'qty', -1)"></i></div></div></div></div></div>
                </div>
                <button class="confirm-btn" onclick="submitData('Bình nóng lạnh')">Xác nhận</button>
            </div>
        </div>
        <div id="lnModal" class="modal-container">
            <div class="modal-content">
                <span class="close-btn" onclick="closeDeviceModal('lnModal')">&times;</span>
                <div class="modal-header"><h2>Lò nướng</h2></div>
                <p class="modal-subtitle">Chọn loại lò nướng bạn có ?</p>

                <div class="type-selector">
                    <div class="type-card inactive" id="card-ln-be" onclick="toggleSelection('ln-be')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-microwave main-icon"></i><span>Lò nướng bé</span>
                    </div>
                    <div class="type-card inactive" id="card-ln-to" onclick="toggleSelection('ln-to')">
                        <i class="fa-solid fa-circle-check check-icon"></i><i class="fa-solid fa-kitchen-set main-icon"></i><span>Lò nướng to</span>
                    </div>
                </div>

                <div class="selected-rows-container">
                    <div class="device-row" id="row-ln-be">
                        <div class="row-title">Thông số: Lò nướng bé</div>
                        <div class="controls-wrapper">
                            <div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-ln-be" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ln-be', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ln-be', 'hours', -0.5)"></i></div></div></div>
                            <div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-ln-be" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ln-be', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ln-be', 'qty', -1)"></i></div></div></div>
                        </div>
                    </div>
                    <div class="device-row" id="row-ln-to">
                        <div class="row-title">Thông số: Lò nướng to</div>
                        <div class="controls-wrapper">
                            <div class="input-group"><label>Số giờ/ngày</label><div class="number-control"><input type="number" id="hours-ln-to" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ln-to', 'hours', 0.5)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ln-to', 'hours', -0.5)"></i></div></div></div>
                            <div class="input-group"><label>Số lượng</label><div class="number-control"><input type="number" id="qty-ln-to" readonly><div class="btn-group"><i class="fa-solid fa-circle-plus action-icon" onclick="changeValue('ln-to', 'qty', 1)"></i><i class="fa-solid fa-circle-minus action-icon" onclick="changeValue('ln-to', 'qty', -1)"></i></div></div></div>
                        </div>
                    </div>
                </div>
                <button class="confirm-btn" onclick="submitData('Lò nướng')">Xác nhận</button>
            </div>
        </div>
        <div style="text-align: center; margin: 40px 0;">
            <button class="btn-primary" style="padding: 12px 40px; font-size: 16px; background-color: #0b4b96; border-radius: 8px;" onclick="calculateTotal()">
                Tính điện năng<br>tiêu thụ
            </button>
        </div>

        <a href="${pageContext.request.contextPath}/home">
            <button class="btn btn-home">
                ← Về Dashboard
            </button>
        </a>

        <div id="result-section" style="display: none; background: #252525; padding: 30px; border-radius: 8px; border: 1px solid #444; margin-bottom: 40px; box-shadow: 0 4px 10px rgba(0,0,0,0.5);">
            <div style="display: flex; gap: 40px; flex-wrap: wrap;">

                <div style="flex: 1; min-width: 300px;">
                    <h3 style="text-align: left; font-size: 16px; margin-bottom: 20px; color: #fff;">Thống kê điện năng các tháng trong năm 2026</h3>
                    <table style="width: 100%; border-collapse: collapse; text-align: center;">
                        <thead>
                            <tr style="border-bottom: 2px solid #444;">
                                <th style="padding: 10px; color: #ccc;">Tháng</th>
                                <th style="padding: 10px; color: #ccc;">Số ngày</th>
                                <th style="padding: 10px; color: #ccc;">Tổng ĐNTT (kWh)</th>
                            </tr>
                        </thead>
                        <tbody id="result-table-body">
                        </tbody>
                    </table>
                </div>

                <div style="flex: 1; min-width: 300px;">
                    <h3 style="text-align: center; font-size: 16px; margin-bottom: 20px; color: #fff;">Điện năng tiêu thụ trong tháng</h3>
                    <canvas id="myChart"></canvas>
                </div>

            </div>
        </div>
        <script>
            // --- KHAI BÁO BIẾN ---
            let isInfoFilled = false;
            let currentHomeType = 'nha-rieng';

            let appState = {
                'don': {active: false, hours: 1, qty: 1, name: 'Bếp đơn'},
                'doi': {active: false, hours: 1, qty: 1, name: 'Bếp đôi'},
                'hq': {active: false, hours: 1, qty: 1, name: 'Đèn huỳnh quang'},
                'led': {active: false, hours: 1, qty: 1, name: 'Đèn LED'},
                'sd': {active: false, hours: 1, qty: 1, name: 'Đèn sợi đốt'},
                'ha': {active: false, hours: 1, qty: 1, name: 'Đèn Halogen'},
                'mg-dung': {active: false, hours: 1, qty: 1, name: 'Máy giặt cửa đứng'},
                'mg-ngang': {active: false, hours: 1, qty: 1, name: 'Máy giặt cửa ngang'},
                'dh-am-tran': {active: false, hours: 1, qty: 1, name: 'Điều hòa âm trần'},
                'dh-tuong': {active: false, hours: 1, qty: 1, name: 'Điều hòa tường'},
                'dh-cay': {active: false, hours: 1, qty: 1, name: 'Điều hòa cây'},
                'ms-quan-ao': {active: false, hours: 1, qty: 1, name: 'Máy sấy quần áo'},
                'bn-15l': {active: false, hours: 1, qty: 1, name: 'Bình 15 lít'},
                'bn-20l': {active: false, hours: 1, qty: 1, name: 'Bình 20 lít'},
                'bn-30l': {active: false, hours: 1, qty: 1, name: 'Bình 30 lít'},
                'ln-be': {active: false, hours: 1, qty: 1, name: 'Lò nướng bé'},
                'ln-to': {active: false, hours: 1, qty: 1, name: 'Lò nướng to'}
            };

            let fridgeState = {
                'mini': {qty: 0, name: 'Tủ lạnh Mini'},
                'tb': {qty: 0, name: 'Tủ lạnh Trung bình'},
                'lon': {qty: 0, name: 'Tủ lạnh Lớn'},
                'cl': {qty: 0, name: 'Tủ lạnh Cực lớn'},
                'dong': {qty: 0, name: 'Tủ đông'}
            };

            // Bảng công suất giả định (W)
            const powerTest = {
                'don': 1000, 'doi': 2000, 'hq': 40, 'led': 15, 'sd': 60, 'ha': 50,
                'mg-dung': 400, 'mg-ngang': 1200,
                'dh-am-tran': 2500, 'dh-tuong': 1000, 'dh-cay': 3000,
                'ms-quan-ao': 2000,
                'bn-15l': 1500, 'bn-20l': 2500, 'bn-30l': 2500,
                'ln-be': 1500, 'ln-to': 2000
            };
            const fridgePower = {'mini': 50, 'tb': 100, 'lon': 150, 'cl': 200, 'dong': 150};

            // --- ĐIỀU KHIỂN MODAL ---
            function openDeviceModal(modalId, itemId) {
                document.querySelectorAll('.device-item').forEach(el => el.classList.remove('active'));
                if (document.getElementById(itemId))
                    document.getElementById(itemId).classList.add('active');
                document.getElementById(modalId).style.display = 'flex';
            }

            function closeDeviceModal(modalId) {
                document.getElementById(modalId).style.display = 'none';
            }

            // --- LOGIC CHỌN THIẾT BỊ ---
            function toggleSelection(type) {
                let state = appState[type];
                state.active = !state.active;
                let cardEl = document.getElementById('card-' + type);
                let rowEl = document.getElementById('row-' + type);

                if (state.active) {
                    cardEl.className = 'type-card active';
                    rowEl.style.display = 'flex';
                    document.getElementById('hours-' + type).value = state.hours;
                    document.getElementById('qty-' + type).value = state.qty;
                } else {
                    cardEl.className = 'type-card inactive';
                    rowEl.style.display = 'none';
                }
            }

            function changeValue(type, field, step) {
                let state = appState[type];
                if (!state.active)
                    return;
                let inputEl = document.getElementById(field + '-' + type);
                let newVal = (parseFloat(inputEl.value) || 0) + step;
                if (newVal >= 0) {
                    if (field === 'hours' && newVal > 24)
                        return;
                    newVal = Math.round(newVal * 10) / 10;
                    inputEl.value = newVal;
                    state[field] = newVal;
                }
            }

            function changeFridgeQty(type, step) {
                let newVal = fridgeState[type].qty + step;
                if (newVal >= 0) {
                    fridgeState[type].qty = newVal;
                    document.getElementById('qty-' + type).value = newVal;
                }
            }

            function updateMrbValue(val) {
                document.getElementById('mrb-badge').innerText = val;
            }

            // --- CẬP NHẬT UI BÊN NGOÀI (CÁI BẠN ĐANG CẦN) ---
            function updateCardUI(itemId, totalKwh) {
                let subtextEl = document.getElementById('subtext-' + itemId);
                let valSubEl = document.getElementById('val-sub-' + itemId);
                let boxEl = document.getElementById('box-' + itemId);
                let valBoxEl = document.getElementById('val-box-' + itemId);
                let arrowEl = document.getElementById('arrow-' + itemId);

                let roundedKwh = Math.round(totalKwh);

                if (roundedKwh > 0) {
                    if (subtextEl)
                        subtextEl.style.display = 'block';
                    if (boxEl)
                        boxEl.style.display = 'flex';
                    if (arrowEl)
                        arrowEl.style.display = 'none';

                    if (valSubEl)
                        valSubEl.innerText = roundedKwh;
                    if (valBoxEl)
                        valBoxEl.innerText = roundedKwh;
                } else {
                    if (subtextEl)
                        subtextEl.style.display = 'none';
                    if (boxEl)
                        boxEl.style.display = 'none';
                    if (arrowEl)
                        arrowEl.style.display = 'block';
                }
            }

            // --- XỬ LÝ DỮ LIỆU & TÍNH TOÁN ---
            function submitData(categoryName) {
                let hasData = false;
                let totalKwh = 0;
                let currentItemId = '';

                for (const key in appState) {
                    let item = appState[key];
                    let isMatch = false;

                    if (categoryName === 'Bếp Điện' && (key === 'don' || key === 'doi')) {
                        isMatch = true;
                        currentItemId = 'item-bep';
                    } else if (categoryName === 'Đèn Chiếu Sáng' && ['hq', 'led', 'sd', 'ha'].includes(key)) {
                        isMatch = true;
                        currentItemId = 'item-den';
                    } else if (categoryName === 'Máy Giặt' && key.startsWith('mg-')) {
                        isMatch = true;
                        currentItemId = 'item-mg';
                    } else if (categoryName === 'Điều hòa' && key.startsWith('dh-')) {
                        isMatch = true;
                        currentItemId = 'item-dieu-hoa';
                    } else if (categoryName === 'Máy Sấy' && key === 'ms-quan-ao') {
                        isMatch = true;
                        currentItemId = 'item-may-say';
                    } else if (categoryName === 'Bình nóng lạnh' && key.startsWith('bn-')) {
                        isMatch = true;
                        currentItemId = 'item-binh-nong';
                    } else if (categoryName === 'Lò nướng' && key.startsWith('ln-')) {
                        isMatch = true;
                        currentItemId = 'item-lo-nuong';
                    }

                    if (isMatch && item.active && item.qty > 0) {
                        hasData = true;
                        let p = powerTest[key] || 1000;
                        totalKwh += (p * item.hours * item.qty * 30) / 1000;
                    }
                }

                if (!hasData) {
                    alert("Bạn chưa chọn thiết bị nào!");
                    return;
                }

                if (currentItemId)
                    updateCardUI(currentItemId, totalKwh);
                document.querySelectorAll('.modal-container').forEach(m => m.style.display = 'none');
            }

            function submitFridgeData() {
                let hasData = false;
                let totalKwh = 0;

                for (const key in fridgeState) {
                    if (fridgeState[key].qty > 0) {
                        hasData = true;
                        let p = fridgePower[key] || 100;
                        totalKwh += (p * 24 * fridgeState[key].qty * 30) / 1000;
                    }
                }

                if (!hasData) {
                    alert("Chưa chọn tủ lạnh!");
                    return;
                }

                updateCardUI('item-tu-lanh', totalKwh);
                closeDeviceModal('tuLanhModal');
            }

            function submitMrbData() {
                let v = parseInt(document.getElementById('mrb-slider').value);
                if (v > 0) {
                    let totalKwh = v * 4 * 1.5;
                    updateCardUI('item-mrb', totalKwh);
                    closeDeviceModal('mrbModal');
                } else {
                    alert("Chưa chọn số lần!");
                }
            }

            function submitTBKData() {
                let hasData = false;
                let totalKwh = 0;

                document.querySelectorAll('.tbk-row').forEach(row => {
                    let qty = parseInt(row.querySelector('.qty-input').value) || 0;
                    let hours = parseFloat(row.querySelector('.hours-input').value) || 0;
                    let power = parseFloat(row.querySelector('.power-input').value) || 0;

                    if (qty > 0) {
                        hasData = true;
                        totalKwh += (power * hours * qty * 30) / 1000;
                    }
                });

                if (!hasData) {
                    alert("Chưa nhập gì!");
                    return;
                }

                updateCardUI('item-tbk', totalKwh);
                closeDeviceModal('tbkModal');
            }

            // --- NHẬP THÔNG TIN KHÁCH HÀNG ---
            function openInfoScreen() {
                if (confirm("Thông báo:\nBạn cần nhập thông tin khách hàng để tiếp tục.")) {
                    document.getElementById('main-screen').style.display = 'none';
                    document.getElementById('info-screen').style.display = 'block';
                }
            }

            function selectHomeType(type) {
                currentHomeType = type;
                document.getElementById('type-nha-rieng').className = (type === 'nha-rieng' ? 'home-type-card active' : 'home-type-card');
                document.getElementById('type-chung-cu').className = (type === 'chung-cu' ? 'home-type-card active' : 'home-type-card');
                document.getElementById('img-nha-rieng').style.display = (type === 'nha-rieng' ? 'block' : 'none');
                document.getElementById('img-chung-cu').style.display = (type === 'chung-cu' ? 'block' : 'none');
            }

            function changeInfoQty(f, s) {
                let el = document.getElementById('qty-' + f);
                let v = parseInt(el.innerText) + s;
                if (v >= 0)
                    el.innerText = v;
            }

            function saveCustomerInfo() {
                let n = document.getElementById('info-name').value;
                let p = document.getElementById('info-phone').value;
                if (!n || !p) {
                    alert("Nhập tên và SĐT!");
                    return;
                }

                document.getElementById('disp-name').innerText = n;
                document.getElementById('disp-phone').innerText = p;
                document.getElementById('disp-email').innerText = document.getElementById('info-email').value || "(Trống)";
                document.getElementById('disp-city').innerText = document.getElementById('city-select').value;
                document.getElementById('disp-home').innerText = (currentHomeType === 'nha-rieng' ? "Nhà riêng" : "Chung cư") + " - " + document.getElementById('qty-phong-ngu').innerText + " PN";

                document.getElementById('info-details-area').style.display = 'block';
                isInfoFilled = true;
                document.getElementById('info-screen').style.display = 'none';
                document.getElementById('main-screen').style.display = 'block';
            }

            function checkHeavyDevice(m, i) {
                if (!isInfoFilled) {
                    openInfoScreen();
                    return;
                }
                openDeviceModal(m, i);
            }
            // Biến lưu trữ tổng số điện của từng thiết bị
            let categoryTotals = {};
            const categoryNames = {
                'item-bep': 'Bếp điện', 'item-den': 'Đèn chiếu sáng', 'item-tu-lanh': 'Tủ lạnh',
                'item-mrb': 'Máy rửa bát', 'item-mg': 'Máy giặt', 'item-tbk': 'Thiết bị khác',
                'item-dieu-hoa': 'Điều hòa', 'item-may-say': 'Máy sấy',
                'item-binh-nong': 'Bình nóng lạnh', 'item-lo-nuong': 'Lò nướng'
            };

            function updateCardUI(itemId, totalKwh) {
                let subtextEl = document.getElementById('subtext-' + itemId);
                let valSubEl = document.getElementById('val-sub-' + itemId);
                let boxEl = document.getElementById('box-' + itemId);
                let valBoxEl = document.getElementById('val-box-' + itemId);
                let arrowEl = document.getElementById('arrow-' + itemId);

                let roundedKwh = Math.round(totalKwh);

                if (roundedKwh > 0) {
                    categoryTotals[itemId] = roundedKwh; // Lưu dữ liệu vào biến

                    if (subtextEl)
                        subtextEl.style.display = 'block';
                    if (boxEl)
                        boxEl.style.display = 'flex';
                    if (arrowEl)
                        arrowEl.style.display = 'none';

                    if (valSubEl)
                        valSubEl.innerText = roundedKwh;
                    if (valBoxEl)
                        valBoxEl.innerText = roundedKwh;
                } else {
                    delete categoryTotals[itemId]; // Xóa nếu bằng 0

                    if (subtextEl)
                        subtextEl.style.display = 'none';
                    if (boxEl)
                        boxEl.style.display = 'none';
                    if (arrowEl)
                        arrowEl.style.display = 'block';
                }
            }

            let myChartInstance = null;

            function calculateTotal() {
                let total = 0;
                let labels = [];
                let data = [];

                // Gom dữ liệu từ biến categoryTotals
                for (let id in categoryTotals) {
                    total += categoryTotals[id];
                    labels.push(categoryNames[id]);
                    data.push(categoryTotals[id]);
                }

                if (total === 0) {
                    alert("Bạn chưa chọn thiết bị nào!");
                    return;
                }

                // Mở khóa khu vực kết quả
                let resultSection = document.getElementById('result-section');
                resultSection.style.display = 'block';

                // Làm tròn số
                let finalTotal = Math.round(total);
                let tbody = document.getElementById('result-table-body');

                // Cách ghi đè HTML này an toàn 100%, không bị lỗi biến
                tbody.innerHTML =
                        "<tr>" +
                        "<td style='padding: 15px; border-bottom: 1px solid #444; color: #fff;'>3</td>" +
                        "<td style='padding: 15px; border-bottom: 1px solid #444; color: #fff;'>31</td>" +
                        "<td style='padding: 15px; border-bottom: 1px solid #444; color: #f39c12; font-weight: bold; font-size: 22px;'>" + finalTotal + "</td>" +
                        "</tr>";

                // Khối bảo vệ (Try-Catch): Nếu lỗi biểu đồ thì bảng vẫn hiện bình thường
                try {
                    let ctx = document.getElementById('myChart').getContext('2d');
                    if (myChartInstance) {
                        myChartInstance.destroy();
                    }
                    myChartInstance = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                    label: 'Điện năng (kWh)',
                                    data: data,
                                    backgroundColor: '#155e9c',
                                    barPercentage: 0.4
                                }]
                        },
                        options: {
                            responsive: true,
                            plugins: {legend: {display: false}},
                            scales: {y: {beginAtZero: true}}
                        }
                    });
                } catch (err) {
                    console.log("Chưa tải được biểu đồ Chart.js: ", err);
                }

                // Cuộn trang xuống để xem
                resultSection.scrollIntoView({behavior: 'smooth'});
            }
        </script>
    </body>
</html>