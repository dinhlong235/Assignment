<%@page import="model.Payments"%>

<%
Payments payment =
(Payments) request.getAttribute("payment");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Payment</title>
</head>
<body>

<h2>Edit Payment</h2>

<form action="../payments" method="post">

<input type="hidden" name="action" value="edit">

<input type="hidden"
       name="id"
       value="<%=payment.getPaymentId()%>">

Amount:

<input type="number"
       step="0.01"
       name="amount"
       value="<%=payment.getAmount()%>"
       required>

<br><br>

Payment Date:

<input type="datetime-local"
       name="paymentDate"
       required>

<br><br>

Status:

<select name="status">

<option value="PENDING"
<%=payment.getStatus().equals("PENDING")?"selected":""%>>
PENDING
</option>

<option value="PAID"
<%=payment.getStatus().equals("PAID")?"selected":""%>>
PAID
</option>

<option value="FAILED"
<%=payment.getStatus().equals("FAILED")?"selected":""%>>
FAILED
</option>

</select>

<br><br>

User ID:

<input type="number"
       name="userId"
       value="<%=payment.getUserId().getUserId()%>"
       required>

<br><br>

Order ID:

<input type="number"
       name="orderId"
       value="<%=payment.getOrderId().getOrderId()%>"
       required>

<br><br>

<button type="submit">
Update Payment
</button>

</form>

<br>

<a href="../payments">
Back
</a>

</body>
</html>