<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>

<h2>Register</h2>

<form action="/Energy_backend/register" method="post">

    Fullname:
    <input type="text" name="fullname" required>
    <br><br>

    Email:
    <input type="email" name="email" required>
    <br><br>

    Password:
    <input type="password" name="password" required>
    <br><br>

    <button type="submit">REGISTER</button>

</form>

<br>
<a href="${pageContext.request.contextPath}/web/login.jsp">
    Go to Login
</a>

</body>
</html>