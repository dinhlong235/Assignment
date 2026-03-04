<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Create User</title>
</head>
<body>

<h2>Create New User</h2>

<form action="${pageContext.request.contextPath}/users" method="post">

    <input type="hidden" name="action" value="insert">

    Name:
    <input type="text"
           name="username"
           required>
    <br><br>

    Email:
    <input type="email"
           name="email"
           required>
    <br><br>

    Password:
    <input type="password"
           name="password"
           required>
    <br><br>

    User Type:
    <select name="userType" required>
        <option value="home">Home</option>
        <option value="business">Business</option>
        <option value="admin">Admin</option>
    </select>
    <br><br>

    <button type="submit">
        Create
    </button>

</form>

<br>

<a href="${pageContext.request.contextPath}/users">Back</a>

</body>
</html>