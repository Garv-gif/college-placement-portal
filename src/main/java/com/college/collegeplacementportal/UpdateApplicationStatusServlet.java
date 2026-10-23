
package com.college.collegeplacementportal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateApplicationStatusServlet")
public class UpdateApplicationStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String idValue = request.getParameter("application_id");
        String status = request.getParameter("status");

        if (idValue == null || status == null
                || !status.matches("Pending|Shortlisted|Rejected|Selected")) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid application ID or status.");
            return;
        }

        int applicationId;

        try {
            applicationId = Integer.parseInt(idValue);

            if (applicationId <= 0) {
                throw new NumberFormatException();
            }

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid application ID.");
            return;
        }

        String sql = "UPDATE applications SET status = ? "
                + "WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, applicationId);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                response.sendRedirect(
                        "adminApplications.jsp?message=updated");
            } else {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Application not found.");
            }

        } catch (Exception e) {
            getServletContext().log(
                    "Failed to update application status", e);

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Could not update application status.");
        }
    }
}
