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

@WebServlet("/DeleteMemberServlet")
public class DeleteMemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberId = request.getParameter("Member_ID");

        try {
            // Load MySQL Driver and establish connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // SQL query to delete a member
            String query = "DELETE FROM club_member WHERE Club_Member_ID = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(memberId));

            // Execute update
            pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the welcomePresident.jsp page
        response.sendRedirect("welcomePresident.jsp");
    }
}
