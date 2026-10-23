
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.college.collegeplacementportal.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Object studentIdObj = session.getAttribute("studentId");

    if (studentIdObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int studentId = (Integer) studentIdObj;
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications - CareerConnect</title>
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
            padding: 18px 8%;
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

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h1 {
            color: #173b72;
        }

        .application-card {
            background: white;
            padding: 24px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.07);
            border: 1px solid #e7ebf2;
        }

        .application-card h2 {
            color: #173b72;
            margin-top: 0;
        }

        .details {
            color: #52627a;
            line-height: 1.8;
        }

        .status {
            display: inline-block;
            background: #fef3c7;
            color: #92400e;
            padding: 7px 12px;
            border-radius: 6px;
            font-weight: bold;
        }

        .empty {
            background: white;
            padding: 24px;
            border-radius: 12px;
        }

        footer {
            text-align: center;
            padding: 22px;
            color: #64748b;
        }
    </style>
</head>

<body>

    <nav>
        <h2>CareerConnect</h2>
        <div>
            <a href="index.jsp">Home</a>
            <a href="jobs.jsp">Jobs</a>
            <a href="myApplications.jsp">My Applications</a>
        </div>
    </nav>

    <div class="container">
        <h1>My Applications</h1>
        <p>View the jobs you have applied for and their current status.</p>

        <%
            String sql =
                "SELECT a.application_id, a.application_date, a.status, "
                + "j.company_name, j.job_title, j.location, j.salary "
                + "FROM applications a "
                + "JOIN jobs j ON a.job_id = j.job_id "
                + "WHERE a.student_id = ? "
                + "ORDER BY a.application_date DESC";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, studentId);

                try (ResultSet rs = ps.executeQuery()) {
                    boolean found = false;

                    while (rs.next()) {
                        found = true;
        %>

        <div class="application-card">
            <h2><%= rs.getString("job_title") %></h2>

            <p class="details">
                Company: <%= rs.getString("company_name") %><br>
                Location: <%= rs.getString("location") %><br>
                Salary: <%= rs.getString("salary") %><br>
                Applied on: <%= rs.getTimestamp("application_date") %>
            </p>

            <p>
                Status:
                <span class="status">
                    <%= rs.getString("status") %>
                </span>
            </p>
        </div>

        <%
                    }

                    if (!found) {
        %>
            <div class="empty">
                You have not applied for any jobs yet.
                <a href="jobs.jsp">Explore jobs</a>
            </div>
        <%
                    }
                }

            } catch (Exception e) {
                application.log("Error loading student applications", e);
        %>
            <p>Unable to load your applications. Please try again.</p>
        <%
            }
        %>
    </div>

    <footer>
        © 2026 CareerConnect | College Placement Portal
    </footer>

</body>
</html>
