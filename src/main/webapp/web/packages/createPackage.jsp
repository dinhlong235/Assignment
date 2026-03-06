<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Create Package</title>

        <style>

            body{
                margin:0;
                font-family:Arial;
                background:#f4f6f9;
            }

            /* MAIN */

            .main{
                margin-left:220px;
                padding:30px;
            }

            .card{
                background:white;
                padding:25px;
                border-radius:10px;
                box-shadow:0 2px 8px rgba(0,0,0,0.1);
                width:500px;
            }

            .form-group{
                margin-bottom:15px;
            }

            label{
                font-weight:bold;
                display:block;
                margin-bottom:5px;
            }

            input, select, textarea{
                width:100%;
                padding:8px;
                border:1px solid #ccc;
                border-radius:5px;
            }

            .btn{
                padding:10px 18px;
                border:none;
                border-radius:5px;
                cursor:pointer;
            }

            .btn-primary{
                background:#1a5d36;
                color:white;
            }

            .btn-primary:hover{
                background:#14502d;
            }

            .btn-back{
                background:#ccc;
                margin-left:10px;
            }

        </style>

    </head>

    <body>

        <!-- MAIN -->

        <div class="main">

            <div class="card">

                <h2>Create New Package</h2>

                <form action="${pageContext.request.contextPath}/packages" method="post">

                    <input type="hidden" name="action" value="insert">

                    <div class="form-group">
                        <label>Package Name</label>
                        <input type="text" name="name" required>
                    </div>

                    <div class="form-group">
                        <label>Price</label>
                        <input type="number" name="price" step="0.01" required>
                    </div>

                    <div class="form-group">
                        <label>Type</label>
                        <select name="type">
                            <option value="household">Household</option>
                            <option value="solar">Solar</option>
                            <option value="wind">Wind</option>
                            <option value="business">Business</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="4"></textarea>
                    </div>

                    <button class="btn btn-primary" type="submit">
                        Create Package
                    </button>

                    <a href="${pageContext.request.contextPath}/packages">
                        <button type="button" class="btn btn-back">
                            Back
                        </button>
                    </a>

                </form>

            </div>

        </div>

    </body>
</html>