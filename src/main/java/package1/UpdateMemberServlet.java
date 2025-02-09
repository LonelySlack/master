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

@WebServlet("/UpdateMemberServlet")
public class UpdateMemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberId = request.getParameter("Member_ID");

        try {
            // Load MySQL Driver and establish connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            // SQL query to fetch the selected member's details
            String query = "SELECT * FROM club_member WHERE Club_Member_ID = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(memberId));

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Pass member details to the next JSP page
                request.setAttribute("Member_ID", rs.getInt("Club_Member_ID"));
                request.setAttribute("Student_ID", rs.getString("Student_ID"));
                request.setAttribute("Club_ID", rs.getString("Club_ID"));
                request.setAttribute("Member_Status", rs.getString("Member_Status"));
                request.setAttribute("Register_Date", rs.getDate("Register_Date"));
                request.setAttribute("Role_ID", rs.getString("Role_ID"));
                
                // Forward to updateMember.jsp
                request.getRequestDispatcher("updateMember.jsp").forward(request, response);
            }

            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("President_clubmember.jsp");
        }
    }
}
