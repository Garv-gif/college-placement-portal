
package com.college.collegeplacementportal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String course = request.getParameter("course");
        String yearText = request.getParameter("graduation_year");

        try (PrintWriter out = response.getWriter()) {

            if (name == null || email == null || password == null
                    || course == null || yearText == null
                    || name.isBlank() || email.isBlank()
                    || password.isBlank() || course.isBlank()
                    || yearText.isBlank()) {

                out.println("<h3>Please fill all fields.</h3>");
                return;
            }

            int graduationYear = Integer.parseInt(yearText);

            // Hash the password before saving it
            String hashedPassword = PasswordUtil.hashPassword(password);

            String sql = "INSERT INTO students "
                    + "(name, email, password, course, graduation_year) "
                    + "VALUES (?, ?, ?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, hashedPassword);
                ps.setString(4, course);
                ps.setInt(5, graduationYear);

                ps.executeUpdate();

                out.println("<h2>Registration Successful!</h2>");
                out.println("<a href='login.jsp'>Login Now</a>");

            } catch (java.sql.SQLIntegrityConstraintViolationException e) {
                out.println("<h3>This email is already registered.</h3>");
                out.println("<a href='register.jsp'>Try Again</a>");
            } catch (Exception e) {
    out.println("<h3>Registration failed: "
            + e.getMessage() + "</h3>");
}

        } catch (NumberFormatException e) {
            response.getWriter().println(
                    "<h3>Graduation year must be a number.</h3>");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
