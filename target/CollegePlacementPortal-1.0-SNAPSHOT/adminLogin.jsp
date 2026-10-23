
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - CareerConnect</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #243047;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-box {
            background: white;
            width: 90%;
            max-width: 430px;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
        }

        h1 {
            text-align: center;
            color: #173b72;
            font-size: 26px;
        }

        p {
            text-align: center;
            color: #64748b;
        }

        label {
            display: block;
            margin-top: 18px;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 15px;
        }

        button {
            width: 100%;
            margin-top: 24px;
            padding: 12px;
            background: #2457a7;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #173b72;
        }

        .links {
            text-align: center;
            margin-top: 18px;
        }

        a {
            color: #2457a7;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <h1>Admin Login</h1>
        <p>CareerConnect Administration</p>

        <form action="AdminLoginServlet" method="post">
            <label>Username</label>
            <input type="text" name="username"
                   required maxlength="100">

            <label>Password</label>
            <input type="password" name="password" required>

            <button type="submit">Login as Admin</button>
        </form>

        <div class="links">
            <a href="login.jsp">Back to Student Login</a>
        </div>
    </div>

</body>
</html>
