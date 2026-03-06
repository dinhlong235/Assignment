<%@page import="java.util.List"%>
<%@page import="model.Payments"%>

<%
    List<Payments> list
            = (List<Payments>) request.getAttribute("listPayments");
%>

<h2>Payments</h2>

<table border="1">

    <tr>
        <th>ID</th>
        <th>Amount</th>
        <th>Status</th>
    </tr>

    <% for (Payments p : list) {%>

    <tr>

        <td><%=p.getPaymentId()%></td>

        <td><%=p.getAmount()%></td>

        <td><%=p.getStatus()%></td>

    </tr>

    <% }%>

</table>