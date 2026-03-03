<%@page import="model.Suppliers"%>

<%
Suppliers supplier =
(Suppliers) request.getAttribute("supplier");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Supplier</title>
</head>
<body>

<h2>Edit Supplier</h2>

<form action="<%=request.getContextPath()%>/suppliers" method="post">

<input type="hidden" name="action" value="edit">

<input type="hidden"
       name="id"
       value="<%=supplier.getSupplierId()%>">

Name:
<input type="text"
       name="name"
       value="<%=supplier.getName()%>"
       required>

<br><br>

Type:
<input type="text"
       name="type"
       value="<%=supplier.getType()%>"
       required>

<br><br>

Contact Info:
<input type="text"
       name="contactInfo"
       value="<%=supplier.getContactInfo()%>"
       required>

<br><br>

<button type="submit">
Update Supplier
</button>

</form>

<br>

<a href="<%=request.getContextPath()%>/suppliers">
Back
</a>

</body>
</html>