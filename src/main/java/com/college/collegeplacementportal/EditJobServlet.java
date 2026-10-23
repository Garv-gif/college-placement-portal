
package com.college.collegeplacementportal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditJobServlet")
public class EditJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession(false) == null
                || request.getSession(false).getAttribute("adminId") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String jobId = request.getParameter("job_id");
        String companyName = request.getParameter("company_name");
        String jobTitle = request.getParameter("job_title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String salary = request.getParameter("salary");
        String eligibility = request.getParameter("eligibility");

        if (jobId == null || companyName == null || jobTitle == null
                || description == null || location == null
                || salary == null || eligibility == null
                || companyName.isBlank() || jobTitle.isBlank()) {
            response.sendRedirect("adminJobs.jsp?message=invalid");
            return;
        }

        String sql = "UPDATE jobs SET company_name=?, job_title=?, "
                + "description=?, location=?, salary=?, eligibility=? "
                + "WHERE job_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, companyName.trim());
            ps.setString(2, jobTitle.trim());
            ps.setString(3, description.trim());
            ps.setString(4, location.trim());
            ps.setString(5, salary.trim());
            ps.setString(6, eligibility.trim());
            ps.setInt(7, Integer.parseInt(jobId));

            int updated = ps.executeUpdate();

            if (updated > 0) {
                response.sendRedirect("adminJobs.jsp?message=updated");
            } else {
                response.sendRedirect("adminJobs.jsp?message=notfound");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("adminJobs.jsp?message=invalid");
        } catch (Exception e) {
            throw new ServletException("Unable to update job.", e);
        }
    }
}
