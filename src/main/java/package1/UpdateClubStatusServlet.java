package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateClubStatusServlet")
public class UpdateClubStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int clubId = Integer.parseInt(request.getParameter("Club_ID"));
        String clubStatus = request.getParameter("Club_Status");

        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            // Database connection
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // Update query
            String query = "UPDATE club SET Club_Status = ? WHERE Club_ID = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, clubStatus);
            pst.setInt(2, clubId);
            pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the admin dashboard
        response.sendRedirect("welcomeAdmin.jsp");
    }
}