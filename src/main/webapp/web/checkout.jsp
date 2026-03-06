<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thanh toán - VOLTSTREAM</title>

        <style>
            body{
                margin:0;
                font-family:Segoe UI, sans-serif;
                background:#f1f5f9;
                display:flex;
                justify-content:center;
                align-items:center;
                height:100vh;
            }

            .checkout-card{
                width:420px;
                background:white;
                padding:30px;
                border-radius:16px;
                box-shadow:0 10px 30px rgba(0,0,0,0.08);
            }

            .title{
                font-size:22px;
                font-weight:bold;
                margin-bottom:25px;
            }

            .info{
                margin-bottom:20px;
                padding:15px;
                background:#f8fafc;
                border-radius:10px;
            }

            .info p{
                margin:8px 0;
            }

            .price{
                font-size:22px;
                font-weight:bold;
                color:#2563eb;
                margin-top:10px;
            }

            .btn{
                width:100%;
                padding:12px;
                border:none;
                border-radius:8px;
                font-size:15px;
                cursor:pointer;
                margin-top:15px;
                transition:0.2s;
            }

            .btn-pay{
                background:#16a34a;
                color:white;
            }

            .btn-pay:hover{
                background:#15803d;
            }

            .btn-back{
                background:#e2e8f0;
                color:#334155;
            }

            .btn-back:hover{
                background:#cbd5e1;
            }

            .logo{
                text-align:center;
                font-weight:bold;
                font-size:20px;
                color:#2563eb;
                margin-bottom:20px;
            }
        </style>
    </head>

    <body>

        <c:if test="${order != null}">

            <div class="checkout-card">

                <div class="logo">⚡ VOLTSTREAM</div>

                <div class="title">Xác nhận thanh toán</div>

                <div class="info">
                    <p><strong>Tên gói:</strong></p>
                    <p>${order.packageId.name}</p>

                    <p><strong>Số tiền:</strong></p>
                    <div class="price">
                        ${order.packageId.price} VND
                    </div>
                </div>

                <form action="payments" method="post">
                    <input type="hidden" name="action" value="pay"/>
                    <input type="hidden" name="orderId" 
                           value="${order.orderId}"/>

                    <button class="btn btn-pay">
                        💳 Thanh toán ngay
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/home">
                    <button class="btn btn-back">
                        ← Quay lại Dashboard
                    </button>
                </a>

            </div>

        </c:if>

    </body>
</html>