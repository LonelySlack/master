package package1;
//test//
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Admin_UpdateEventServlet", urlPatterns = {"/Admin_UpdateEventServlet"})
public class Admin_UpdateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver"); // ✅ Use the latest MySQL driver
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // ✅ Secure session handling (Ensure only admins can access this)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Admin_ID") == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }

        // ✅ Retrieve event details from request
        String eventIdStr = request.getParameter("Event_ID");
        String approvalStatus = request.getParameter("Approval_Status");

        // ✅ Validate inputs
        if (eventIdStr == null || approvalStatus == null || eventIdStr.trim().isEmpty() || approvalStatus.trim().isEmpty()) {
            response.getWriter().println("<script>alert('Invalid input. Please try again.');window.location.href='Admin_ApproveEvent.jsp';</script>");
            return;
        }

        int eventId = Integer.parseInt(eventIdStr.trim());

        // ✅ Update event status in the database
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String updateQuery = "UPDATE event SET Event_Status = ? WHERE Event_ID = ?";
            try (PreparedStatement pst = con.prepareStatement(updateQuery)) {
                pst.setString(1, approvalStatus);
                pst.setInt(2, eventId);

                int rowsUpdated = pst.executeUpdate();
                if (rowsUpdated > 0) {
                    response.getWriter().println("<script>alert('Event updated successfully!');window.location.href='Admin_ApproveEvent.jsp';</script>");
                } else {
                    response.getWriter().println("<script>alert('Failed to update event. Try again.');window.location.href='Admin_ApproveEvent.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error: " + e.getMessage() + "');window.location.href='Admin_ApproveEvent.jsp';</script>");
        }
    }
}
