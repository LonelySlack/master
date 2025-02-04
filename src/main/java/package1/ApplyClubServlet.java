package package1;

import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ApplyClubServlet", urlPatterns = { "/ApplyClubServlet" })
public class ApplyClubServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        // Retrieve parameters from the form
        String studentId = request.getParameter("Student_ID");
        String clubId = request.getParameter("Club_ID");

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            // Check if the student has already applied to the club
            String checkQuery = "SELECT COUNT(*) AS Application_Count FROM club_member WHERE Student_ID = ? AND Club_ID = ?";
            pst = con.prepareStatement(checkQuery);
            pst.setString(1, studentId);
            pst.setString(2, clubId);
            rs = pst.executeQuery();

            if (rs.next() && rs.getInt("Application_Count") > 0) {
                // Redirect with an error message if already applied
                response.sendRedirect("ApplyClub.jsp?error=AlreadyApplied");
                return;
            }

            // Insert into club_member table with Pending status and default role as Member
            String insertQuery = "INSERT INTO club_member (Student_ID, Club_ID, Member_Status, Register_Date, Role_ID) VALUES (?, ?, ?, NOW(), ?)";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, studentId);
            pst.setString(2, clubId);
            pst.setString(3, "Pending");
            pst.setInt(4, 4); // Role ID 4 is assumed to be 'Member'
            pst.executeUpdate();

            // Redirect to a success page or back to the club application page
            response.sendRedirect("ApplyClub.jsp?success=ApplicationSuccessful");
        } catch (Exception e) {
            e.printStackTrace();
            // Forward to an error page or display an error message
            request.setAttribute("errorMessage", "Error occurred while applying for the club. Please try again.");
            request.getRequestDispatcher("ApplyClub.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}