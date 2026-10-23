
package com.college.collegeplacementportal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {

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

            if (password.length() < 8) {
                out.println("<h3>Password must be at least 8 characters.</h3>");
                return;
            }

            String sql = "INSERT INTO admins (username, password) VALUES (?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                String hashedPassword =
                        PasswordUtil.hashPassword(password);

                ps.setString(1, username);
                ps.setString(2, hashedPassword);

                ps.executeUpdate();

                out.println("<h2>Admin registered successfully!</h2>");
                out.println("<a href='adminLogin.jsp'>Go to Admin Login</a>");

            } catch (SQLException e) {
                if (e.getErrorCode() == 1062) {
                    out.println("<h3>This username already exists.</h3>");
                    out.println("<a href='adminRegister.jsp'>Try another username</a>");
                } else {
                    getServletContext().log(
                            "Admin registration failed", e);
                    out.println("<h3>Registration failed. Check the server output.</h3>");
                }
            } catch (Exception e) {
                getServletContext().log(
                        "Admin registration failed", e);
                out.println("<h3>Registration failed. Check the server output.</h3>");
            }
        }
    }
}
