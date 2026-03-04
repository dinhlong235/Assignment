<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tài khoản của tôi</title>
        <style>
            .box {
                border: 1px solid #ddd;
                padding: 20px;
                margin: 20px 0;
                border-radius: 8px;
                background-color: #f9f9f9;
            }

            .success {
                background-color: #e8f5e9;
                border-color: #4caf50;
            }

            .pending {
                background-color: #fff8e1;
                border-color: #ff9800;
            }

            .empty {
                background-color: #fce4ec;
                border-color: #e91e63;
            }

            .btn {
                padding: 8px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }

            .btn-pay {
                background-color: #ff9800;
                color: white;
            }

            .btn-register {
                background-color: #2196f3;
                color: white;
            }
        </style>
    </head>
    <body>

        <h2>Tài khoản của tôi</h2>

        <c:set var="user" value="${sessionScope.user}" />

        <c:if test="${user == null}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <p>Xin chào <b>${user.fullName}</b> 
            (<a href="logout">Đăng xuất</a>)
        </p>

        <h3>Gói dịch vụ của bạn:</h3>

        <!-- ========================= -->
        <!-- TRƯỜNG HỢP 1: KHÔNG CÓ ORDER -->
        <!-- ========================= -->
        <c:if test="${pendingOrder == null && activeOrder == null}">
            <div class="box empty">
                Bạn chưa đăng kí gói dịch vụ nào.<br><br>
                Nhanh tay đăng ký gói dịch vụ của chúng tôi để nhận được dịch vụ tận tình và nhanh chóng nhất.
                <br><br>
                <a href="service-packages" class="btn btn-register">Đăng ký ngay</a>
            </div>
        </c:if>


        <!-- ========================= -->
        <!-- TRƯỜNG HỢP 2: CÓ ORDER PENDING -->
        <!-- ========================= -->
        <c:if test="${pendingOrder != null && activeOrder == null}">
            <div class="box pending">
                Bạn đã đăng kí gói dịch vụ 
                <b>${pendingOrder.packageId.packageName}</b><br><br>

                Trạng thái: <b>Chưa thanh toán</b><br>
                Số tiền cần thanh toán: 
                <b>${pendingOrder.packageId.price}</b> VND
                <br><br>

                <form action="payments" method="get">
                    <input type="hidden" name="action" value="checkout"/>
                    <input type="hidden" name="orderId" value="${pendingOrder.orderId}"/>
                    <button type="submit" class="btn btn-pay">
                        Thanh toán
                    </button>
                </form>
            </div>
        </c:if>


        <!-- ========================= -->
        <!-- TRƯỜNG HỢP 3: CÓ ORDER ACTIVE -->
        <!-- ========================= -->
        <c:if test="${activeOrder != null}">
            <div class="box success" style="padding:25px">

                <h3 style="margin-bottom:15px; color:#2e7d32;">
                    ✔ Gói dịch vụ đang hoạt động
                </h3>

                <table style="width:100%; border-collapse:collapse;">
                    <tr>
                        <td style="padding:8px; font-weight:bold;">Tên gói:</td>
                        <td style="padding:8px;">
                            ${activeOrder.packageId.packageName}
                        </td>
                    </tr>

                    <tr>
                        <td style="padding:8px; font-weight:bold;">Nhà cung cấp:</td>
                        <td style="padding:8px;">
                            ${activeOrder.packageId.providerId.providerName}
                        </td>
                    </tr>

                    <tr>
                        <td style="padding:8px; font-weight:bold;">Giá gói:</td>
                        <td style="padding:8px;">
                            ${activeOrder.packageId.price} VND
                        </td>
                    </tr>

                    <tr>
                        <td style="padding:8px; font-weight:bold;">Ngày đăng ký:</td>
                        <td style="padding:8px;">
                            ${activeOrder.orderDate}
                        </td>
                    </tr>

                    <tr>
                        <td style="padding:8px; font-weight:bold;">Trạng thái:</td>
                        <td style="padding:8px; color:#2e7d32; font-weight:bold;">
                            Đang hoạt động
                        </td>
                    </tr>
                </table>

                <hr style="margin:20px 0">

                <p style="font-size:13px; color:#555;">
                    Gói dịch vụ của bạn hiện đang được kích hoạt.
                    Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của chúng tôi.
                </p>

            </div>
        </c:if>


        <hr>

        <h3>Chi tiết tài khoản</h3>

        <p><b>Tên:</b> ${user.fullName}</p>
        <p><b>Email:</b> ${user.email}</p>

    </body>
</html>