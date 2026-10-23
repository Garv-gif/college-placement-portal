
package com.college.collegeplacementportal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteJobServlet")
public class DeleteJobServlet extends HttpServlet {

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

        try {
            if (jobId == null || jobId.isBlank()) {
                response.sendRedirect("adminJobs.jsp?message=invalid");
                return;
            }

            String sql = "DELETE FROM jobs WHERE job_id=?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, Integer.parseInt(jobId));
                int deleted = ps.executeUpdate();

                if (deleted > 0) {
                    response.sendRedirect("adminJobs.jsp?message=deleted");
                } else {
                    response.sendRedirect("adminJobs.jsp?message=notfound");
                }
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("adminJobs.jsp?message=invalid");
        } catch (Exception e) {
            // A job may be linked to applications through a foreign key.
            response.sendRedirect("adminJobs.jsp?message=error");
        }
    }
}
