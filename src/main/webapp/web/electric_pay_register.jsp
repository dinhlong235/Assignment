<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Xác nhận đăng ký</title>
    </head>
    <body>

        <h2>Xác nhận đăng ký gói dịch vụ</h2>

        <c:if test="${servicePackage != null}">

            <p><strong>Tên gói:</strong> 
                ${servicePackage.packageName}
            </p>

            <p><strong>Nhà cung cấp:</strong> 
                ${servicePackage.providerId.providerName}
            </p>

            <p><strong>Giá:</strong> 
                ${servicePackage.price} VND
            </p>

            <form action="OrderServlet" method="post">
                <input type="hidden" 
                       name="packageId" 
                       value="${servicePackage.packageId}" />
                <button>Xác nhận đăng ký</button>
            </form>

        </c:if>

    </body>
</html>