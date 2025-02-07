package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateEventStatusServlet", urlPatterns = {"/UpdateEventStatusServlet"})
public class UpdateEventStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    static {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Secure session handling (Ensure only admins can access this)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Admin_ID") == null) {
            response.sendRedirect("LoginAdmin.jsp");
            return;
        }

        // Retrieve event details from the request
        String eventIdStr = request.getParameter("Event_ID");
        String eventStatus = request.getParameter("Event_Status");

        // Validate inputs
        if (eventIdStr == null || eventStatus == null || eventIdStr.trim().isEmpty() || eventStatus.trim().isEmpty()) {
            response.getWriter().println("<script>alert('Invalid input. Please try again.');window.location.href='Admin_eventdetails.jsp';</script>");
            return;
        }

        int eventId;
        try {
            eventId = Integer.parseInt(eventIdStr.trim());
        } catch (NumberFormatException e) {
            response.getWriter().println("<script>alert('Invalid Event ID format. Please try again.');window.location.href='Admin_eventdetails.jsp';</script>");
            return;
        }

        // Update event status in the database
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String updateQuery = "UPDATE event SET Event_Status = ? WHERE Event_ID = ?";
            try (PreparedStatement pst = con.prepareStatement(updateQuery)) {
                pst.setString(1, eventStatus);
                pst.setInt(2, eventId);

                int rowsUpdated = pst.executeUpdate();
                if (rowsUpdated > 0) {
                    response.getWriter().println("<script>alert('Event status updated successfully!');window.location.href='Admin_eventdetails.jsp';</script>");
                } else {
                    response.getWriter().println("<script>alert('Failed to update event status. Try again.');window.location.href='Admin_eventdetails.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error: " + e.getMessage() + "');window.location.href='Admin_eventdetails.jsp';</script>");
        }
    }
}