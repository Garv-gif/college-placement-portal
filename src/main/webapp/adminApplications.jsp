
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.college.collegeplacementportal.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String sql = "SELECT a.application_id, s.name, s.email, "
            + "j.company_name, j.job_title, a.application_date, a.status "
            + "FROM applications a "
            + "JOIN students s ON a.student_id = s.student_id "
            + "JOIN jobs j ON a.job_id = j.job_id "
            + "ORDER BY a.application_date DESC";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Applications - CareerConnect</title>
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
            padding: 20px 6%;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        h1 {
            color: #173b72;
        }

        .table-wrap {
            overflow-x: auto;
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.06);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        th, td {
            padding: 13px;
            border-bottom: 1px solid #e2e8f0;
            text-align: left;
        }

        th {
            background: #e4edff;
            color: #173b72;
        }

        select, button {
            padding: 8px;
            border-radius: 5px;
        }

        select {
            border: 1px solid #ccd4e0;
        }

        button {
            background: #2457a7;
            color: white;
            border: none;
            cursor: pointer;
        }

        .empty {
            padding: 25px;
            text-align: center;
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
    <a href="addJob.jsp">Add Job</a>
<a href="AdminLogoutServlet">Logout</a></nav>

<div class="container">
    <h1>Student Applications</h1>

    <% if ("updated".equals(request.getParameter("message"))) { %>
        <p class="message">Application status updated successfully!</p>
    <% } %>

    <div class="table-wrap">
        <table>
            <tr>
                <th>ID</th>
                <th>Student</th>
                <th>Email</th>
                <th>Company</th>
                <th>Job Title</th>
                <th>Applied On</th>
                <th>Status</th>
                <th>Update Status</th>
            </tr>

            <%
                boolean found = false;

                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps = con.prepareStatement(sql);
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {
                        found = true;
                        String status = rs.getString("status");
            %>

            <tr>
                <td><%= rs.getInt("application_id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("company_name") %></td>
                <td><%= rs.getString("job_title") %></td>
                <td><%= rs.getTimestamp("application_date") %></td>
                <td><%= status %></td>

                <td>
                    <form action="UpdateApplicationStatusServlet"
                          method="post">

                        <input type="hidden" name="application_id"
                               value="<%= rs.getInt("application_id") %>">

                        <select name="status" required>
                            <option value="Pending"
                                <%= "Pending".equals(status) ? "selected" : "" %>>
                                Pending
                            </option>

                            <option value="Shortlisted"
                                <%= "Shortlisted".equals(status) ? "selected" : "" %>>
                                Shortlisted
                            </option>

                            <option value="Rejected"
                                <%= "Rejected".equals(status) ? "selected" : "" %>>
                                Rejected
                            </option>

                            <option value="Selected"
                                <%= "Selected".equals(status) ? "selected" : "" %>>
                                Selected
                            </option>
                        </select>

                        <button type="submit">Update</button>
                    </form>
                </td>
            </tr>

            <%
                    }

                    if (!found) {
            %>
                <tr>
                    <td colspan="8" class="empty">
                        No student applications found yet.
                    </td>
                </tr>
            <%
                    }

                } catch (Exception e) {
                    application.log("Unable to load applications", e);
            %>
                <tr>
                    <td colspan="8" class="empty">
                        Could not load applications. Check the server output.
                    </td>
                </tr>
            <%
                }
            %>
        </table>
    </div>

    <p><a href="adminDashboard.jsp">← Back to Dashboard</a></p>
</div>

</body>
</html>
