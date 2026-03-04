<!DOCTYPE html>
<html>
<head>
    <title>Create Payment</title>
</head>
<body>

<h2>Create Payment</h2>

<form action="../payments" method="post">

<input type="hidden" name="action" value="create">

Amount:

<input type="number"
       step="0.01"
       name="amount"
       required>

<br><br>

Payment Date:

<input type="datetime-local"
       name="paymentDate"
       required>

<br><br>

Status:

<select name="status">

<option value="PENDING">PENDING</option>

<option value="PAID">PAID</option>

<option value="FAILED">FAILED</option>

</select>

<br><br>

User ID:

<input type="number"
       name="userId"
       required>

<br><br>

Order ID:

<input type="number"
       name="orderId"
       required>

<br><br>

<button type="submit">
Create Payment
</button>

</form>

<br>

<a href="../payments">
Back
</a>

</body>
</html>