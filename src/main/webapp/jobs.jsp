
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.college.collegeplacementportal.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Available Jobs - CareerConnect</title>
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

        .hero {
            background: #e4edff;
            padding: 45px 8%;
            text-align: center;
        }

        .hero h1 {
            color: #173b72;
            margin-bottom: 10px;
        }

        .hero p {
            color: #52627a;
        }

        .container {
            max-width: 1100px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .message {
            padding: 14px 18px;
            margin-bottom: 22px;
            border-radius: 8px;
            font-weight: bold;
        }

        .success {
            color: #166534;
            background: #dcfce7;
        }

        .duplicate {
            color: #92400e;
            background: #fef3c7;
        }

        .error {
            color: #991b1b;
            background: #fee2e2;
        }

        .job-card {
            background: white;
            padding: 24px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.07);
            border: 1px solid #e7ebf2;
        }

        .job-card h2 {
            color: #173b72;
            margin-top: 0;
        }

        .company {
            font-weight: bold;
            color: #475569;
        }

        .details {
            color: #52627a;
            line-height: 1.8;
        }

        .apply-btn {
            display: inline-block;
            background: #2457a7;
            color: white;
            padding: 11px 22px;
            border: none;
            border-radius: 6px;
            margin-top: 10px;
            font-size: 15px;
            cursor: pointer;
            font-family: Arial, sans-serif;
        }

        .apply-btn:hover {
            background: #173b72;
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
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <section class="hero">
        <h1>Explore Job Opportunities</h1>
        <p>Find opportunities to start your professional career.</p>
    </section>

    <div class="container">

        <%
            String message = request.getParameter("message");

            if ("success".equals(message)) {
        %>
            <div class="message success">
                Application submitted successfully!
            </div>
        <%
            } else if ("duplicate".equals(message)) {
        %>
            <div class="message duplicate">
                You have already applied for this job!
            </div>
        <%
            } else if ("error".equals(message)) {
        %>
            <div class="message error">
                Something went wrong. Please try again.
            </div>
        <%
            }
        %>

        <%
            String sql = "SELECT * FROM jobs ORDER BY posted_date DESC";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                boolean found = false;

                while (rs.next()) {
                    found = true;
        %>

        <div class="job-card">
            <h2><%= rs.getString("job_title") %></h2>

            <p class="company">
                <%= rs.getString("company_name") %>
            </p>

            <p class="details">
                Description: <%= rs.getString("description") %><br>
                Location: <%= rs.getString("location") %><br>
                Salary: <%= rs.getString("salary") %><br>
                Eligibility: <%= rs.getString("eligibility") %>
            </p>

            <form action="ApplyServlet" method="post">
                <input type="hidden" name="jobId"
                       value="<%= rs.getInt("job_id") %>">

                <button type="submit" class="apply-btn">
                    Apply Now
                </button>
            </form>
        </div>

        <%
                }

                if (!found) {
        %>
            <p>No jobs are currently available.</p>
        <%
                }

            } catch (Exception e) {
                application.log("Error loading jobs from database", e);
        %>
            <p>Unable to load jobs. Please check the database connection.</p>
        <%
            }
        %>

    </div>

    <footer>
        © 2026 CareerConnect | College Placement Portal
    </footer>

</body>
</html>
