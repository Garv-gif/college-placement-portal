
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Job - CareerConnect</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
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
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
        }

        .container {
            max-width: 650px;
            margin: 35px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        h1 {
            color: #173b72;
        }

        label {
            display: block;
            margin-top: 17px;
            font-weight: bold;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin-top: 7px;
            border: 1px solid #ccd4e0;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 15px;
        }

        textarea {
            resize: vertical;
            min-height: 90px;
        }

        button {
            margin-top: 22px;
            padding: 12px 22px;
            background: #2457a7;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #173b72;
        }

        .message {
            color: #176b38;
            font-weight: bold;
        }
    </style>
</head>

<body>

<nav>
    <a href="adminDashboard.jsp">Dashboard</a>
    <a href="adminApplications.jsp">Applications</a>
    <a href="AdminLogoutServlet">Logout</a>
</nav>

<div class="container">
    <h1>Add a New Job</h1>
    <p>Enter the job details below.</p>

    <% if ("success".equals(request.getParameter("message"))) { %>
        <p class="message">Job added successfully!</p>
    <% } %>

    <form action="AddJobServlet" method="post">

        <label>Company Name</label>
        <input type="text" name="company_name" maxlength="150" required>

        <label>Job Title</label>
        <input type="text" name="job_title" maxlength="150" required>

        <label>Job Description</label>
        <textarea name="description" required></textarea>

        <label>Location</label>
        <input type="text" name="location" maxlength="150" required>

        <label>Salary / Package</label>
        <input type="text" name="salary" maxlength="100" required
               placeholder="e.g. 3.5 LPA or 15000/month">

        <label>Eligibility Criteria</label>
        <textarea name="eligibility" required
                  placeholder="e.g. BCA/MCA, basic Java and SQL"></textarea>

        <button type="submit">Add Job</button>
    </form>

    <p><a href="adminDashboard.jsp">← Back to Dashboard</a></p>
</div>

</body>
</html>
