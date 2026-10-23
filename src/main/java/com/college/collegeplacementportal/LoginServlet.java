
package com.college.collegeplacementportal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {

            if (email == null || password == null
                    || email.isBlank() || password.isBlank()) {
                out.println("<h3>Please enter email and password.</h3>");
                return;
            }

            String sql = "SELECT student_id, name, password "
                    + "FROM students WHERE email = ?";

            try (Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, email);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        String storedPassword = rs.getString("password");

                        if (PasswordUtil.verifyPassword(
                                password, storedPassword)) {

                            HttpSession session = request.getSession();
                            session.setAttribute(
                                    "studentId", rs.getInt("student_id"));
                            session.setAttribute(
                                    "studentName", rs.getString("name"));

                            out.println("<h2>Login Successful!</h2>");
                            out.println("<h3>Welcome, "
                                    + escapeHtml(rs.getString("name"))
                                    + "!</h3>");
                            out.println("<a href='jobs.jsp'>View Jobs</a>");

                        } else {
                            out.println("<h3>Invalid email or password.</h3>");
                            out.println("<a href='login.jsp'>Try Again</a>");
                        }

                    } else {
                        out.println("<h3>Invalid email or password.</h3>");
                        out.println("<a href='login.jsp'>Try Again</a>");
                    }
                }

            } catch (Exception e) {
                out.println("<h3>Login failed. Please check the server output.</h3>");
            }
        }
    }

    private String escapeHtml(String value) {
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}
