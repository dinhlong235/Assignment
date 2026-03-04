<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ServicePackages"%>
<%@page import="controller.ServicePackagesJpaController"%>
<%@page import="jakarta.persistence.Persistence"%>
<%@page import="jakarta.persistence.EntityManagerFactory"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Nhận Đăng Ký</title>
</head>
<body>

    <%
        // 1. Lấy ID từ URL
        String idStr = request.getParameter("id");
        ServicePackages pkg = null;
        String error = null;

        if (idStr != null && !idStr.isEmpty()) {
            try {
                // 2. Kết nối Database (Lưu ý tên EnergyPU)
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("EnergyPU");
                ServicePackagesJpaController controller = new ServicePackagesJpaController(emf);
                
                int pkgId = Integer.parseInt(idStr);
                pkg = controller.findServicePackages(pkgId); 
                
                emf.close();
            } catch (Exception e) {
                error = "Lỗi kết nối: " + e.getMessage();
            }
        } else {
            error = "Không tìm thấy mã gói cước!";
        }
    %>

    <a href="home.jsp"> <-- Quay lại Dashboard</a>
    <hr/>

    <% if (pkg != null) { %>
        <h1>Xác Nhận Đăng Ký</h1>
        
        <p><strong>Tên gói cước:</strong> <%= pkg.getName() %></p>
        <p><strong>Loại hình:</strong> <%= pkg.getPackageType() %></p>
        <p><strong>Nhà cung cấp:</strong> <%= (pkg.getSupplierId() != null) ? pkg.getSupplierId().getName() : "N/A" %></p>
        <p><strong>Mô tả:</strong> <%= pkg.getDescription() %></p>
        
        <h3>Thành tiền: <%= String.format("%,.0f", pkg.getPrice()) %> VNĐ</h3>

        <form action="OrdersServlet" method="POST">
            <input type="hidden" name="package_id" value="<%= pkg.getPackageId() %>">
            
            <button type="submit" style="height: 40px; font-size: 16px; cursor: pointer;">
                Xác Nhận Mua Ngay
            </button>
        </form>

    <% } else { %>
        <h3 style="color:red;">Lỗi: <%= (error != null) ? error : "Gói cước không tồn tại." %></h3>
    <% } %>

</body>
</html>