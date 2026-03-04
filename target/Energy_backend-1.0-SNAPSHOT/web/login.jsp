<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login</h2>

<form action="${pageContext.request.contextPath}/login" method="post">

    UserName:<br>
    <input type="text" name="username" required>
    <br><br>

    Password:<br>
    <input type="password" name="password" required>
    <br><br>

    <input type="submit" value="Login">

</form>

<br>

<a href="${pageContext.request.contextPath}/web/register.jsp">
    Register new account
</a>

</body>
</html>