<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users"%>
<%
    Users user = (Users) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
    if(!user.getUserType().equals("admin")){
        response.sendRedirect("home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>

<h2>Trang quản trị ADMIN</h2>

Xin chào ADMIN: <b><%= user.getName() %></b>

<br><br>

<a href="${pageContext.request.contextPath}/users">
    Manage Users
</a>
<br>
<a href="${pageContext.request.contextPath}/suppliers">Manage Suppliers</a>
<br>
<a href="${pageContext.request.contextPath}/payments">Manage Payments</a>

<br><br>

<a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>

</body>
</html>