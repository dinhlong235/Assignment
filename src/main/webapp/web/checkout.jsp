<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán</title>
    </head>
    <body>

        <h2>Xác nhận thanh toán</h2>

    <c:set var="order" value="${order}" />

    <p><b>Tên gói:</b> ${order.packageId.packageName}</p>
    <p><b>Nhà cung cấp:</b> ${order.packageId.providerId.providerName}</p>
    <p><b>Số tiền:</b> ${order.packageId.price} VND</p>

    <hr>

    <form action="payments" method="post">
        <input type="hidden" name="action" value="pay"/>
        <input type="hidden" name="orderId" value="${order.orderId}"/>

        <label>Chọn phương thức thanh toán:</label><br>
        <input type="radio" name="method" value="bank" checked> Chuyển khoản<br>
        <input type="radio" name="method" value="momo"> Ví điện tử<br>
        <input type="radio" name="method" value="cash"> Tiền mặt<br><br>

        <button type="submit">Xác nhận thanh toán</button>
    </form>

    <br>
    <a href="account">Quay lại tài khoản</a>

</body>
</html>