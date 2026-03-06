<%@page import="model.Users"%>

<%
Users user = (Users) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
</head>
<body>

<h2>Edit User</h2>

<form action="users" method="post">

<input type="hidden"
       name="action"
       value="edit">

<input type="hidden"
       name="id"
       value="<%=user.getUserId()%>">

Name:

<input type="text"
       name="username"
       value="<%=user.getName()%>"
       required>

<br><br>

Email:

<input type="email"
       name="email"
       value="<%=user.getEmail()%>"
       required>

<br><br>

Password:

<input type="password"
       name="password"
       value="<%=user.getPasswordHash()%>"
       required>

<br><br>

<button type="submit">
Update
</button>

</form>

<br>

<a href="users">Back</a>

</body>
</html>