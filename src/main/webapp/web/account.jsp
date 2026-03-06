<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>My Account</title>
        <style>
            body {
                font-family: Arial;
                margin: 40px;
            }
            .card {
                border:1px solid #ddd;
                padding:20px;
                border-radius:8px;
                margin-bottom:20px;
            }
            .btn {
                padding:10px 20px;
                background:#007bff;
                color:white;
                border:none;
                border-radius:5px;
                cursor:pointer;
            }
            .btn:hover {
                background:#0056b3;
            }
            .success {
                color:green;
            }
            .pending {
                color:orange;
            }
        </style>
    </head>
    <body>

        <h2>Account Service Status</h2>

        <c:choose>

            <%-- CASE 1: Có active order --%>
            <c:when test="${activeOrder != null}">
                <div class="card">
                    <h3 class="success">Dịch vụ đang hoạt động</h3>

                    <p><strong>Tên gói:</strong> 
                        ${activeOrder.packageId.name}
                    </p>

                    <p><strong>Nhà cung cấp:</strong> 
                        ${activeOrder.packageId.supplierId.name}
                    </p>

                    <p><strong>Giá gói:</strong> 
                        ${activeOrder.packageId.price} VND
                    </p>

                    <p><strong>Ngày đăng ký:</strong> 
                        ${activeOrder.orderDate}
                    </p>

                    <p><strong>Trạng thái:</strong> 
                        ${activeOrder.status}
                    </p>
                </div>
                <a href="${pageContext.request.contextPath}/home">
                    <button>Về trang chủ</button>
                </a>
            </c:when>

            <%-- CASE 2: Có pending order --%>
            <c:when test="${pendingOrder != null}">
                <div class="card">
                    <h3 class="pending">Dịch vụ đang chờ thanh toán</h3>

                    <p><strong>Tên gói:</strong> 
                        ${pendingOrder.packageId.name}
                    </p>

                    <p><strong>Giá:</strong> 
                        ${pendingOrder.packageId.price} VND
                    </p>

                    <form action="payments" method="get">
                        <input type="hidden" name="action" value="checkout"/>
                        <input type="hidden" name="orderId" 
                               value="${pendingOrder.orderId}"/>
                        <button class="btn">Thanh toán ngay</button>
                    </form>
                </div>
                <a href="${pageContext.request.contextPath}/home">
                    <button>Về trang chủ</button>
                </a>
            </c:when>

            <%-- CASE 3: Không có order nào --%>
            <c:otherwise>
                <div class="card">
                    <h3>Bạn chưa đăng ký dịch vụ</h3>
                    <a href="${pageContext.request.contextPath}/OrderServlet">
                        <button class="btn">Đăng ký ngay</button>
                    </a>
                </div>
                <a href="${pageContext.request.contextPath}/home">
                    <button>Về trang chủ</button>
                </a>
            </c:otherwise>

        </c:choose>

    </body>
</html>