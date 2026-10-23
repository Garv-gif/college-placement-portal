
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Registration - CareerConnect</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            margin: 0;
            padding: 40px 15px;
        }

        .container {
            max-width: 450px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px #00000012;
        }

        h2 {
            text-align: center;
            color: #173b70;
        }

        label {
            display: block;
            margin-top: 16px;
            margin-bottom: 6px;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
        }

        button {
            width: 100%;
            margin-top: 24px;
            padding: 13px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        p {
            text-align: center;
            margin-top: 20px;
        }

        a {
            color: #2563eb;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Create Student Account</h2>

    <form action="RegisterServlet" method="post">

        <label>Full Name</label>
        <input type="text" name="name" required>

        <label>Email Address</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <label>Course</label>
        <input type="text" name="course" placeholder="e.g. MCA Data Science" required>

        <label>Graduation Year</label>
        <input type="number" name="graduation_year"
               min="2020" max="2100" required>

        <button type="submit">Register</button>
    </form>

    <p>Already registered? <a href="login.jsp">Login here</a></p>
    <p><a href="index.jsp">Back to Home</a></p>
</div>

</body>
</html>
