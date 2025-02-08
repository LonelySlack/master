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

@WebServlet("/SaveMemberServlet")
public class SaveMemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberId = request.getParameter("Member_ID");
        String memberStatus = request.getParameter("Member_Status");
        String roleId = request.getParameter("Role_ID");
        String registerDate = request.getParameter("Register_Date");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");


            // SQL query to update member details
            String query = "UPDATE club_member SET Member_Status = ?, Role_ID = ?, Register_Date = ? WHERE Club_Member_ID = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, memberStatus);
            pst.setString(2, roleId);
            pst.setString(3, registerDate);
            pst.setInt(4, Integer.parseInt(memberId));

            pst.executeUpdate();
            pst.close();
            con.close();

            response.sendRedirect("President_clubmember.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateMember.jsp");
        }
    }
}
