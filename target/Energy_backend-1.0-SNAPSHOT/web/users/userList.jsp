<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Users"%>

<%
    List<Users> list = (List<Users>) request.getAttribute("listUsers");
%>

<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
</head>
<body>

<h2>User Management</h2>

<a href="users?action=create">Create New User</a>

<br><br>

<table border="1">

<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Action</th>
</tr>

<% for(Users u : list){ %>

<tr>

<td><%=u.getUserId()%></td>

<td><%=u.getName()%></td>

<td><%=u.getEmail()%></td>

<td>

<a href="users?action=edit&id=<%=u.getUserId()%>">
Edit
</a>

|

<a href="users?action=delete&id=<%=u.getUserId()%>"
onclick="return confirm('Delete user?')">
Delete
</a>

</td>

</tr>

<% } %>

</table>

<br>

<a href="admin.jsp">Back to Admin</a>

</body>
</html>