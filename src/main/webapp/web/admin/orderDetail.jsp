<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Orders"%>
<%@page import="model.Payments"%>
<%@page import="model.Users"%>

<%
    Users admin = (Users) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getUserType())) {
        response.sendRedirect(request.getContextPath() + "/web/login.jsp");
        return;
    }

    Orders order = (Orders) request.getAttribute("order");
    List<Payments> payments
            = (List<Payments>) request.getAttribute("payments");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <style>
            body{
                font-family:Segoe UI;
                background:#f0f2f5;
                padding:30px;
            }
            .card{
                background:white;
                padding:20px;
                border-radius:12px;
                box-shadow:0 2px 10px rgba(0,0,0,0.05);
            }
            table{
                width:100%;
                border-collapse:collapse;
                margin-top:15px;
            }
            th,td{
                padding:10px;
                border-bottom:1px solid #eee;
            }
            th{
                background:#f9fafb;
            }
        </style>
    </head>

    <body>

        <div class="card">

            <h2>Chi tiết đơn hàng #<%=order.getOrderId()%></h2>

            <p><b>Người dùng:</b> <%=order.getUserId().getName()%></p>
            <p><b>Gói:</b> <%=order.getPackageId().getName()%></p>
            <p><b>Ngày đặt:</b> <%=order.getOrderDate()%></p>
            <p><b>Trạng thái:</b> <%=order.getStatus()%></p>

            <h3>Lịch sử thanh toán</h3>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Số tiền</th>
                    <th>Ngày thanh toán</th>
                    <th>Trạng thái</th>
                </tr>

                <% if (payments != null && !payments.isEmpty()) {
        for (Payments p : payments) {%>

                <tr>
                    <td><%=p.getPaymentId()%></td>
                    <td><%=p.getAmount()%></td>
                    <td><%=p.getPaymentDate()%></td>
                    <td><%=p.getStatus()%></td>
                </tr>

                <% }
} else { %>
                <tr><td colspan="4">Chưa có thanh toán</td></tr>
                <% }%>

            </table>

        </div>

    </body>
</html>