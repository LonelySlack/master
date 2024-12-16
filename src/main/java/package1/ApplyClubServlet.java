package package1;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "ApplyClubServlet", urlPatterns = { "/ApplyClubServlet" })
public class ApplyClubServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        String studentId = request.getParameter("Student_ID");
        String clubId = request.getParameter("Club_ID");

        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // Insert into club_member table with Pending status and default role as Member
            String insertQuery = "INSERT INTO club_member (Student_ID, Club_ID, Member_Status, Register_Date, Role_ID) VALUES (?, ?, ?, NOW(), ?)";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, studentId);
            pst.setString(2, clubId);
            pst.setString(3, "Pending");
            pst.setInt(4, 4); // Role ID 4 is assumed to be 'Member'

            pst.executeUpdate();

            response.sendRedirect("welcome.jsp?message=Application Successful. Awaiting approval.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error occurred while applying for the club. Try again.");
            request.getRequestDispatcher("ApplyClub.jsp").forward(request, response);
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
