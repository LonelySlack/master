package package1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet(name = "UpdateStatusServlet", urlPatterns = {"/UpdateStatusServlet"})
public class UpdateStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clubIdStr = request.getParameter("Club_ID");

        if (clubIdStr == null || clubIdStr.trim().isEmpty()) {
            response.sendRedirect("ApplyClub.jsp?error=Invalid club ID.");
            return;
        }

        int clubId;
        try {
            clubId = Integer.parseInt(clubIdStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect("ApplyClub.jsp?error=Invalid club ID format.");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;

        try {
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Update the status of the club to "Pending"
            String updateQuery = "UPDATE club SET Club_Status = 'Pending' WHERE Club_ID = ?";
            pst = con.prepareStatement(updateQuery);
            pst.setInt(1, clubId);

            int rowsUpdated = pst.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("ApplyClub.jsp?success=Status updated to Pending successfully.");
            } else {
                response.sendRedirect("ApplyClub.jsp?error=Failed to update status. Please try again.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ApplyClub.jsp?error=Database error: " + e.getMessage());
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}