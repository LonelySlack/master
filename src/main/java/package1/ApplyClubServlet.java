package package1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
//test
@WebServlet(name = "ApplyClubServlet", urlPatterns = {"/ApplyClubServlet"})
public class ApplyClubServlet extends HttpServlet 
{
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies

        String studentId = request.getParameter("Student_ID");
        String clubIdStr = request.getParameter("Club_ID");

        if (studentId == null || clubIdStr == null) {
        	response.getWriter().println("<script>alert('Invalid Request');window.location.href='ApplyClub.jsp';</script>");
            return;
        }

        int clubId;
        try {
            clubId = Integer.parseInt(clubIdStr.trim());
        } catch (NumberFormatException e) {
        	response.getWriter().println("<script>alert('Invalid club ID');window.location.href='ApplyClub.jsp';</script>");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check if the student is already a member of any club
            String checkMembershipQuery = "SELECT COUNT(*) AS Membership_Count FROM club_member WHERE Student_ID = ?";
            pst = con.prepareStatement(checkMembershipQuery);
            pst.setString(1, studentId);
            rs = pst.executeQuery();

            if (rs.next() && rs.getInt("Membership_Count") > 0) {
            	response.getWriter().println("<script>alert('You can only join one club!');window.location.href='ApplyClub.jsp';</script>");
                return;
            }

            // Insert the application into the club_member table
            String insertQuery = "INSERT INTO club_member (Student_ID, Club_ID, Member_Status, Register_Date, Role_ID) VALUES (?, ?, 'Pending', CURDATE(), 2)";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, studentId);
            pst.setInt(2, clubId);
            pst.executeUpdate();

            response.getWriter().println("<script>alert('Your Application have been successfully sumbited');window.location.href='ApplyClub.jsp';</script>");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occured when processing your request');window.location.href='ApplyClub.jsp';</script>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}