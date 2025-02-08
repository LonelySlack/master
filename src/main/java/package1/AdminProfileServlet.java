package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminProfileServlet", urlPatterns = {"/AdminProfileServlet"})
public class AdminProfileServlet extends HttpServlet {
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
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve session and validate
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Admin_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Extract form parameters
        String adminIdStr = request.getParameter("admin_id");
        String adminName = request.getParameter("admin_name");
        String contactNumber = request.getParameter("contact_number");
        String newPassword = request.getParameter("password");

        int adminId;
        try {
            adminId = Integer.parseInt(adminIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("Admin_UpdateProfile.jsp?error=Invalid Admin ID.");
            return;
        }

        // Update admin profile in the database
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String updateQuery = "UPDATE admin SET Admin_Name = ?, Admin_Contact_Num = ?";
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                updateQuery += ", Admin_Password = ?";
            }
            updateQuery += " WHERE Admin_ID = ?";

            try (PreparedStatement pst = con.prepareStatement(updateQuery)) {
                pst.setString(1, adminName);
                pst.setString(2, contactNumber);
                int paramIndex = 3;

                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    pst.setString(paramIndex++, newPassword);
                }

                pst.setInt(paramIndex, adminId);

                int rowsUpdated = pst.executeUpdate();
                if (rowsUpdated > 0) {
                    // Update session attributes
                    session.setAttribute("Admin_Name", adminName);
                    session.setAttribute("Admin_Contact_Num", contactNumber);

                    response.sendRedirect("Admin_Profile.jsp?message=Profile updated successfully!");
                } else {
                    response.sendRedirect("Admin_UpdateProfile.jsp?error=Failed to update profile.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Admin_UpdateProfile.jsp?error=Database error occurred: " + e.getMessage());
        }
    }
}