
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Placement Portal</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #1e293b;
        }

        nav {
            background: #173b70;
            color: white;
            padding: 20px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav h2 {
            font-size: 22px;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .hero {
            text-align: center;
            padding: 100px 20px;
            background: white;
        }

        .hero h1 {
            font-size: 42px;
            margin-bottom: 18px;
            color: #173b70;
        }

        .hero p {
            font-size: 18px;
            color: #64748b;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            background: #2563eb;
            color: white;
            padding: 13px 24px;
            border-radius: 6px;
            text-decoration: none;
            margin: 5px;
        }

        .features {
            display: flex;
            justify-content: center;
            gap: 25px;
            padding: 45px 8%;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            padding: 28px;
            border-radius: 10px;
            width: 270px;
            text-align: center;
            box-shadow: 0 3px 12px #00000010;
        }

        .card h3 {
            margin-bottom: 12px;
            color: #173b70;
        }

        footer {
            text-align: center;
            padding: 22px;
            background: #173b70;
            color: white;
        }
    </style>
</head>

<body>

<nav>
    <h2>CareerConnect</h2>
    <div>
        <a href="index.jsp">Home</a>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    </div>
</nav>

<section class="hero">
    <h1>Build Your Career With Us</h1>
    <p>Discover opportunities, apply for jobs, and take the next step in your career.</p>
    <a href="jobs.jsp" class="btn">Explore Jobs</a>
    <a href="register.jsp" class="btn">Join Now</a>
</section>

<section class="features">
    <div class="card">
        <h3>Find Opportunities</h3>
        <p>Explore job openings from different companies.</p>
    </div>

    <div class="card">
        <h3>Apply Online</h3>
        <p>Submit applications for jobs that match your skills.</p>
    </div>

    <div class="card">
        <h3>Track Applications</h3>
        <p>Keep track of the status of your job applications.</p>
    </div>
</section>

<footer>
    <p>College Placement Portal | Your Career Starts Here</p>
</footer>

</body>
</html>
