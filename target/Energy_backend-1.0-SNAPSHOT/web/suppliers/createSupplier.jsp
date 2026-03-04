<!DOCTYPE html>
<html>
<head>
    <title>Create Supplier</title>
</head>
<body>

<h2>Create Supplier</h2>

<form action="${pageContext.request.contextPath}/suppliers" method="post">

<input type="hidden" name="action" value="create">

Name:

<input type="text"
       name="name"
       required>

<br><br>

Type:

<input type="text"
       name="type"
       required>

<br><br>

Contact Info:

<input type="text"
       name="contactInfo"
       required>

<br><br>

<button type="submit">
Create Supplier
</button>

</form>

<br>

<a href="${pageContext.request.contextPath}/suppliers">
Back
</a>

</body>
</html>