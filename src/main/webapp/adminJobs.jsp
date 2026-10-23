
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.college.collegeplacementportal.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    public String esc(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Jobs - CareerConnect</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #243047;
        }

        nav {
            background: #173b72;
            color: white;
            padding: 18px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-left: 16px;
        }

        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 18px;
        }

        .notice {
            padding: 14px;
            margin-bottom: 20px;
            background: #e4edff;
            border-radius: 8px;
        }

        .job {
            background: white;
            padding: 24px;
            margin-bottom: 22px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .job h2 { color: #173b72; }

        label {
            display: block;
            margin-top: 13px;
            font-weight: bold;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font: inherit;
        }

        textarea {
            min-height: 75px;
            resize: vertical;
        }

        button {
            padding: 11px 17px;
            border: 0;
            border-radius: 6px;
            cursor: pointer;
            color: white;
            margin: 14px 8px 0 0;
            font-size: 14px;
        }

        .save { background: #2457a7; }
        .delete { background: #b42318; }

        .empty {
            background: white;
            padding: 25px;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<nav>
    <strong>CareerConnect Admin</strong>
    <div>
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="addJob.jsp">Add Job</a>
        <a href="adminApplications.jsp">Applications</a>
        <a href="AdminLogoutServlet">Logout</a>
    </div>
</nav>

<div class="container">
    <h1>Manage Jobs</h1>
    <p>Edit job details or delete a job posting.</p>

    <% if ("updated".equals(message)) { %>
        <div class="notice">Job updated successfully.</div>
    <% } else if ("deleted".equals(message)) { %>
        <div class="notice">Job deleted successfully.</div>
    <% } else if ("notfound".equals(message)) { %>
        <div class="notice">Job not found or already removed.</div>
    <% } else if ("invalid".equals(message)) { %>
        <div class="notice">Invalid job details. Please check the form.</div>
    <% } else if ("error".equals(message)) { %>
        <div class="notice">
            Job could not be deleted. It may have existing student applications.
        </div>
    <% } %>

    <%
        String sql = "SELECT job_id, company_name, job_title, description, "
                   + "location, salary, eligibility FROM jobs ORDER BY job_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            boolean found = false;

            while (rs.next()) {
                found = true;
    %>

    <div class="job">
        <h2><%= esc(rs.getString("company_name")) %>
            — <%= esc(rs.getString("job_title")) %></h2>

        <form action="EditJobServlet" method="post">
            <input type="hidden" name="job_id"
                   value="<%= rs.getInt("job_id") %>">

            <label>Company Name</label>
            <input type="text" name="company_name" required
                   value="<%= esc(rs.getString("company_name")) %>">

            <label>Job Title</label>
            <input type="text" name="job_title" required
                   value="<%= esc(rs.getString("job_title")) %>">

            <label>Description</label>
            <textarea name="description" required><%= esc(rs.getString("description")) %></textarea>

            <label>Location</label>
            <input type="text" name="location" required
                   value="<%= esc(rs.getString("location")) %>">

            <label>Salary</label>
            <input type="text" name="salary" required
                   value="<%= esc(rs.getString("salary")) %>">

            <label>Eligibility</label>
            <textarea name="eligibility" required><%= esc(rs.getString("eligibility")) %></textarea>

            <button class="save" type="submit">Save Changes</button>
        </form>

        <form action="DeleteJobServlet" method="post"
              onsubmit="return confirm('Are you sure you want to delete this job?');">
            <input type="hidden" name="job_id"
                   value="<%= rs.getInt("job_id") %>">
            <button class="delete" type="submit">Delete Job</button>
        </form>
    </div>

    <%
            }

            if (!found) {
    %>
        <div class="empty">No jobs found in the database.</div>
    <%
            }

        } catch (SQLException e) {
            application.log("Error loading jobs in adminJobs.jsp", e);
    %>
        <div class="notice">
            Unable to load jobs. Check the database connection and server log.
        </div>
    <%
        }
    %>
</div>

</body>
</html>
