
package com.college.collegeplacementportal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ApplyServlet")
public class ApplyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");
        int jobId = Integer.parseInt(request.getParameter("jobId"));

        String sql = "INSERT INTO applications (student_id, job_id) VALUES (?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, jobId);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("jobs.jsp?message=success");
            } else {
                response.sendRedirect("jobs.jsp?message=error");
            }

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                response.sendRedirect("jobs.jsp?message=duplicate");
            } else {
getServletContext().log("Error applying for job", e);                response.sendRedirect("jobs.jsp?message=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("jobs.jsp?message=error");
        }
    }
}
