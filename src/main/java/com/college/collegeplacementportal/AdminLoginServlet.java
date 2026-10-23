
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

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {

            if (username == null || password == null
                    || username.isBlank() || password.isBlank()) {
                out.println("<h3>Please enter username and password.</h3>");
                return;
            }

            String sql = "SELECT admin_id, username, password "
                    + "FROM admins WHERE username = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        String storedPassword = rs.getString("password");

                        if (PasswordUtil.verifyPassword(
                                password, storedPassword)) {

                            HttpSession session = request.getSession();
                            session.setAttribute(
                                    "adminId", rs.getInt("admin_id"));
                            session.setAttribute(
                                    "adminUsername", rs.getString("username"));

                            response.sendRedirect("adminDashboard.jsp");
                            return;

                        } else {
                            out.println("<h3>Invalid username or password.</h3>");
                            out.println("<a href='adminLogin.jsp'>Try Again</a>");
                        }

                    } else {
                        out.println("<h3>Invalid username or password.</h3>");
                        out.println("<a href='adminLogin.jsp'>Try Again</a>");
                    }
                }

            } catch (Exception e) {
                getServletContext().log("Admin login failed", e);
                out.println("<h3>Login failed. Check the server output.</h3>");
            }
        }
    }
}
