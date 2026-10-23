
package com.college.collegeplacementportal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddJobServlet")
public class AddJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (request.getSession(false) == null
                || request.getSession(false).getAttribute("adminId") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String companyName = request.getParameter("company_name");
        String jobTitle = request.getParameter("job_title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String salary = request.getParameter("salary");
        String eligibility = request.getParameter("eligibility");

        if (companyName == null || jobTitle == null
                || description == null || location == null
                || salary == null || eligibility == null
                || companyName.isBlank() || jobTitle.isBlank()
                || description.isBlank() || location.isBlank()
                || salary.isBlank() || eligibility.isBlank()) {

            response.sendRedirect("addJob.jsp?message=error");
            return;
        }

        String sql = "INSERT INTO jobs "
                + "(company_name, job_title, description, location, salary, eligibility) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, companyName.trim());
            ps.setString(2, jobTitle.trim());
            ps.setString(3, description.trim());
            ps.setString(4, location.trim());
            ps.setString(5, salary.trim());
            ps.setString(6, eligibility.trim());

            ps.executeUpdate();

            response.sendRedirect("addJob.jsp?message=success");

        } catch (Exception e) {
            getServletContext().log("Failed to add job", e);
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Could not add the job. Check the server output.");
        }
    }
}
