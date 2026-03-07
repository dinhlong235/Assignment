<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đăng ký dịch vụ - VOLTSTREAM</title>

        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background: #f1f5f9;
            }

            .container {
                width: 90%;
                max-width: 1200px;
                margin: 60px auto;
                text-align: center;
            }

            h2 {
                font-size: 28px;
                margin-bottom: 40px;
                font-weight: bold;
                color: #0f172a;
            }

            .packages {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 25px;
            }

            .card {
                background: white;
                border-radius: 16px;
                padding: 30px 20px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.06);
                transition: 0.3s;
                position: relative;
            }

            .card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            }

            .card h3 {
                margin-bottom: 15px;
                font-size: 20px;
            }

            .price {
                font-size: 24px;
                font-weight: bold;
                color: #2563eb;
                margin: 20px 0;
            }

            .btn {
                padding: 10px 18px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: 0.2s;
            }

            .btn-buy {
                background: #2563eb;
                color: white;
            }

            .btn-buy:hover {
                background: #1e40af;
            }

            .btn-home {
                margin-top: 40px;
                background: #e2e8f0;
                color: #334155;
            }

            .btn-home:hover {
                background: #cbd5e1;
            }

            .badge {
                position: absolute;
                top: 15px;
                right: 15px;
                background: #16a34a;
                color: white;
                padding: 5px 10px;
                font-size: 12px;
                border-radius: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container">

            <h2>⚡ Chọn gói dịch vụ phù hợp với bạn</h2>

            <form action="${pageContext.request.contextPath}/OrderServlet" method="post">

                <div class="packages">

                    <div class="card">
                        <h3>Basic Household Plan</h3>
                        <div class="price">500.000 VNĐ</div>
                        <button class="btn btn-buy" name="packageId" value="1">
                            Mua ngay
                        </button>
                    </div>

                    <div class="card">
                        <div class="badge">POPULAR</div>
                        <h3>Solar Premium</h3>
                        <div class="price">1.200.000 VNĐ</div>
                        <button class="btn btn-buy" name="packageId" value="2">
                            Mua ngay
                        </button>
                    </div>

                    <div class="card">
                        <h3>Wind Industrial</h3>
                        <div class="price">2.500.000 VNĐ</div>
                        <button class="btn btn-buy" name="packageId" value="3">
                            Mua ngay
                        </button>
                    </div>

                </div>

            </form>

            <a href="${pageContext.request.contextPath}/home">
                <button class="btn btn-home">
                    ← Về Dashboard
                </button>
            </a>

        </div>

    </body>
</html>