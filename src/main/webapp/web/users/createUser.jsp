<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Create User</title>

        <style>

            body{
                margin:0;
                font-family:Arial;
                background:#f4f6f9;
            }

            /* MAIN CONTENT */

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

            .card h2{
                margin-bottom:20px;
            }

            .form-group{
                margin-bottom:15px;
            }

            label{
                display:block;
                margin-bottom:5px;
                font-weight:bold;
            }

            input, select{
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

                <h2>Create New User</h2>

                <form action="${pageContext.request.contextPath}/users" method="post">

                    <input type="hidden" name="action" value="insert">

                    <div class="form-group">
                        <label>Name</label>
                        <input type="text"
                               name="username"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email"
                               name="email"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <input type="password"
                               name="password"
                               required>
                    </div>

                    <div class="form-group">
                        <label>User Type</label>

                        <select name="userType" required>
                            <option value="home">Home</option>
                            <option value="business">Business</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>

                    <button class="btn btn-primary" type="submit">
                        Create User
                    </button>

                    <a href="${pageContext.request.contextPath}/users">
                        <button type="button" class="btn btn-back">
                            Back
                        </button>
                    </a>

                </form>

            </div>

        </div>

    </body>
</html>