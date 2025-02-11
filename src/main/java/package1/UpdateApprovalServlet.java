package package1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateApprovalServlet")
public class UpdateApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String applicationId = request.getParameter("Application_ID");
        String approvalStatus = request.getParameter("Approval_Status");

        // Database connection details
        String dbURL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
        String dbUser = "u9946_Kmmw1Vvrcg";
        String dbPassword = "V6y2rsxfO0B636FUWqU^Ia=F";

        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Update query
            String sql = "UPDATE president_application SET Approval_Status = ? WHERE Application_ID = ?";
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                 PreparedStatement pst = con.prepareStatement(sql)) {

                pst.setString(1, approvalStatus);
                pst.setInt(2, Integer.parseInt(applicationId));

                // Execute update
                int rowsUpdated = pst.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("Admin_Applicationpresident.jsp"); // Redirect back to the admin page
                } else {
                    request.setAttribute("errorMessage", "Failed to update the status.");
                    request.getRequestDispatcher("Admin_Applicationpresident.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating the status.");
            request.getRequestDispatcher("Admin_Applicationpresident.jsp").forward(request, response);
        }
    }
}
