
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String adminUsername =
            (String) session.getAttribute("adminUsername");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - CareerConnect</title>
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
        }

        nav {
            background: #173b72;
            color: white;
            padding: 20px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        nav h2 {
            margin: 0;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-left: 18px;
        }

        nav a:hover {
            text-decoration: underline;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .welcome {
            background: #e4edff;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .welcome h1 {
            color: #173b72;
            margin-top: 0;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 22px;
        }

        .card {
            background: white;
            padding: 28px;
            border-radius: 12px;
            border: 1px solid #e7ebf2;
            box-shadow: 0 3px 12px rgba(0,0,0,0.06);
        }

        .card h2 {
            color: #173b72;
            font-size: 21px;
        }

        .card p {
            color: #52627a;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            background: #2457a7;
            color: white;
            padding: 11px 18px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 10px;
        }

        .btn:hover {
            background: #173b72;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #64748b;
        }
    </style>
</head>

<body>

    <nav>
        <h2>CareerConnect Admin</h2>
        <div>
            <a href="adminDashboard.jsp">Dashboard</a>
            <a href="adminApplications.jsp">Applications</a>
            <a href="AdminLogoutServlet">Logout</a>
        </div>
    </nav>

    <div class="container">

        <div class="welcome">
            <h1>Welcome, <%= adminUsername %>!</h1>
            <p>Manage job opportunities and student applications
               from your admin dashboard.</p>
        </div>

        <div class="cards">

            <div class="card">
                <h2>Add New Job</h2>
                <p>Create and publish new job opportunities
                   for students on CareerConnect.</p>
                <a href="addJob.jsp" class="btn">Add New Job</a>
            </div>

            <div class="card">
                <h2>Edit / Delete Jobs</h2>
                <p>View existing job postings, update their details
                   or remove jobs that are no longer available.</p>
                <a href="adminJobs.jsp" class="btn">Manage Jobs</a>
            </div>

            <div class="card">
                <h2>Student Applications</h2>
                <p>View student applications and update their
                   status to Pending, Shortlisted, Rejected or Selected.</p>
                <a href="adminApplications.jsp" class="btn">
                    View Applications
                </a>
            </div>

        </div>

    </div>

    <footer>
        © 2026 CareerConnect | Admin Panel
    </footer>

</body>
</html>
