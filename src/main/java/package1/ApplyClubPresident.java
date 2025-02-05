package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ApplyClubPresident", urlPatterns = {"/ApplyClubPresident"})
public class ApplyClubPresident extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials
    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    // Load JDBC driver
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver"); // Use correct driver for MySQL 8.x
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Student_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("Student_ID");
        String reason = request.getParameter("reason");

        // Ensure "reason" is not null or empty
        if (reason == null || reason.trim().isEmpty()) {
            response.getWriter().println("<script>alert('Reason cannot be empty.');window.location.href='ApplyClubPresident.jsp';</script>");
            return;
        }

        // Initialize database resources
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check if the student already has an active application
            String checkQuery = "SELECT COUNT(*) FROM president_application WHERE Student_ID = ? AND Approval_Status IN ('Pending', 'Approved')";
            pst = con.prepareStatement(checkQuery);
            pst.setString(1, studentId);
            rs = pst.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                response.getWriter().println("<script>alert('You already have an active application.');window.location.href='ApplyClubPresident.jsp';</script>");
                return;
            }

            // Close previous resources
            if (rs != null) rs.close();
            if (pst != null) pst.close();

            // Insert new application with Reason and Admin_ID set to 1
            String sql = "INSERT INTO president_application (Application_Date, Approval_Status, Student_ID, Admin_ID, Reason) " +
                         "VALUES (CURRENT_DATE, 'Pending', ?, 1, ?)";
            pst = con.prepareStatement(sql);
            pst.setString(1, studentId);
            pst.setString(2, reason);

            int rowsInserted = pst.executeUpdate();

            if (rowsInserted > 0) {
                // Redirect to welcome.jsp with success indicator
                response.sendRedirect("welcome.jsp?success=true");
            } else {
                response.getWriter().println("<script>alert('Failed to submit your application. Please try again later.');window.location.href='ApplyClubPresident.jsp';</script>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error occurred: " + e.getMessage() + "');window.location.href='ApplyClubPresident.jsp';</script>");
        } finally {
            // Properly close database resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pst != null) pst.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
