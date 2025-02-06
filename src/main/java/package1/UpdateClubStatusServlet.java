package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateClubStatusServlet", urlPatterns = {"/UpdateClubStatusServlet"})
public class UpdateClubStatusServlet extends HttpServlet {
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

        // Retrieve club details from the request
        String clubIdStr = request.getParameter("Club_ID");
        String clubStatus = request.getParameter("Club_Status");

        // Validate inputs
        if (clubIdStr == null || clubStatus == null || clubIdStr.trim().isEmpty() || clubStatus.trim().isEmpty()) {
            response.getWriter().println("<script>alert('Invalid input. Please try again.');window.location.href='Admin_clubdetails.jsp';</script>");
            return;
        }

        int clubId;
        try {
            clubId = Integer.parseInt(clubIdStr.trim());
        } catch (NumberFormatException e) {
            response.getWriter().println("<script>alert('Invalid Club ID format. Please try again.');window.location.href='Admin_clubdetails.jsp';</script>");
            return;
        }

        // Update club status in the database
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String updateQuery = "UPDATE club SET Club_Status = ? WHERE Club_ID = ?";
            try (PreparedStatement pst = con.prepareStatement(updateQuery)) {
                pst.setString(1, clubStatus);
                pst.setInt(2, clubId);

                int rowsUpdated = pst.executeUpdate();
                if (rowsUpdated > 0) {
                    response.getWriter().println("<script>alert('Club status updated successfully!');window.location.href='Admin_clubdetails.jsp';</script>");
                } else {
                    response.getWriter().println("<script>alert('Failed to update club status. Try again.');window.location.href='Admin_clubdetails.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error: " + e.getMessage() + "');window.location.href='Admin_clubdetails.jsp';</script>");
        }
    }
}