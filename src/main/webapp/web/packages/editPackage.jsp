<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ServicePackages"%>

<%
    ServicePackages pkg = (ServicePackages) request.getAttribute("pkg");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Package</title>

        <style>
            body{
                background:#f4f6f9;
                font-family:Segoe UI;
            }

            .card{
                width:450px;
                margin:80px auto;
                background:white;
                padding:30px;
                border-radius:10px;
                box-shadow:0 3px 12px rgba(0,0,0,0.1);
            }

            h2{
                margin-bottom:20px;
            }

            .form-group{
                margin-bottom:15px;
            }

            label{
                font-weight:600;
            }

            input,textarea{
                width:100%;
                padding:10px;
                border:1px solid #ddd;
                border-radius:5px;
            }

            textarea{
                resize:none;
            }

            button{
                background:#28a745;
                color:white;
                border:none;
                padding:10px 16px;
                border-radius:6px;
                cursor:pointer;
            }

            button:hover{
                background:#218838;
            }

            .back{
                display:block;
                margin-top:10px;
                color:#6f42c1;
                text-decoration:none;
            }
        </style>

    </head>

    <body>

        <div class="card">

            <h2>Edit Package</h2>

            <form action="${pageContext.request.contextPath}/packages" method="post">

                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%=pkg.getPackageId()%>">

                <div class="form-group">
                    <label>Package Name</label>
                    <input type="text"
                           name="name"
                           value="<%=pkg.getName()%>"
                           required>
                </div>

                <div class="form-group">
                    <label>Price</label>
                    <input type="number"
                           name="price"
                           step="0.01"
                           value="<%=pkg.getPrice()%>"
                           required>
                </div>

                <div class="form-group">
                    <label>Type</label>
                    <input type="text"
                           name="packageType"
                           value="<%=pkg.getPackageType()%>">
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description"><%=pkg.getDescription()%></textarea>
                </div>

                <button type="submit">
                    Update Package
                </button>

            </form>

            <a class="back" href="${pageContext.request.contextPath}/packages">
                ← Back to list
            </a>

        </div>

    </body>
</html>