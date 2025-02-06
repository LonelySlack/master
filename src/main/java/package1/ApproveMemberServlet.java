package package1;

import java.io.*;

import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "ApproveMemberServlet", urlPatterns = { "/ApproveMemberServlet" })
public class ApproveMemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int memberId = Integer.parseInt(request.getParameter("Member_ID"));

        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            // Update the Member_Status to "Active"
            String updateQuery = "UPDATE club_member SET Member_Status = 'Active' WHERE Club_Member_ID = ?";
            pst = con.prepareStatement(updateQuery);
            pst.setInt(1, memberId);

            pst.executeUpdate();
            response.sendRedirect("President_home.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("President_home.jsp?error=Approval failed.");
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
