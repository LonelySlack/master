package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CreateClub", urlPatterns = {"/CreateClub"})
public class CreateClub extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Student_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("Student_ID");
        String clubName = request.getParameter("Club_Name");
        String clubDesc = request.getParameter("Club_Desc");
        String clubEmail = request.getParameter("Club_Email");
        String clubCategory = request.getParameter("Club_Category");

        // Log retrieved parameters for debugging
        System.out.println("Student_ID: " + studentId);
        System.out.println("Club_Name: " + clubName);
        System.out.println("Club_Desc: " + clubDesc);
        System.out.println("Club_Email: " + clubEmail);
        System.out.println("Club_Category: " + clubCategory);

        // Validate inputs
        if (clubName == null || clubName.trim().isEmpty() || 
            clubDesc == null || clubDesc.trim().isEmpty() || 
            clubEmail == null || clubEmail.trim().isEmpty() || 
            clubCategory == null || clubCategory.trim().isEmpty()) {
            response.getWriter().println("<script>alert('All fields are required. Please fill out the form completely.');window.location.href='CreateClub.jsp';</script>");
            return;
        }

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Check if the student is already a president of a club
            String checkPresidentQuery = "SELECT COUNT(*) FROM club WHERE President_ID = ?";
            try (PreparedStatement checkPst = con.prepareStatement(checkPresidentQuery)) {
                checkPst.setString(1, studentId);
                try (ResultSet rs = checkPst.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        response.getWriter().println("<script>alert('You are already a president of an existing club!');window.location.href='President_home.jsp';</script>");
                        return;
                    }
                }
            }

            // Insert new club
            String insertClubQuery = "INSERT INTO club (Club_Name, Club_Desc, Club_Est_Date, Club_Email, Club_Category, Club_Status, President_ID) " +
                                     "VALUES (?, ?, CURDATE(), ?, ?, 'Active', ?)";
            try (PreparedStatement pst = con.prepareStatement(insertClubQuery, Statement.RETURN_GENERATED_KEYS)) {
                pst.setString(1, clubName.trim());
                pst.setString(2, clubDesc.trim());
                pst.setString(3, clubEmail.trim());
                pst.setString(4, clubCategory.trim());
                pst.setString(5, studentId);

                int rowsInserted = pst.executeUpdate();
                if (rowsInserted > 0) {
                    // Get the generated Club_ID
                    try (ResultSet generatedKeys = pst.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int clubId = generatedKeys.getInt(1);

                            // Insert the president into the club_member table
                            String insertMemberQuery = "INSERT INTO club_member (Student_ID, Club_ID, Member_Status, Register_Date, Role_ID) " +
                                                       "VALUES (?, ?, 'Active', CURDATE(), 1)";
                            try (PreparedStatement memberPst = con.prepareStatement(insertMemberQuery)) {
                                memberPst.setString(1, studentId);
                                memberPst.setInt(2, clubId);

                                int memberInserted = memberPst.executeUpdate();
                                if (memberInserted > 0) {
                                    response.getWriter().println("<script>alert('Club created successfully! You have been added as the President.');window.location.href='President_home.jsp';</script>");
                                } else {
                                    response.getWriter().println("<script>alert('Failed to add you as the President. Please contact the administrator.');window.location.href='CreateClub.jsp';</script>");
                                }
                            }
                        }
                    }
                } else {
                    response.getWriter().println("<script>alert('Failed to create the club. Please try again later.');window.location.href='CreateClub.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error occurred: " + e.getMessage() + "');window.location.href='CreateClub.jsp';</script>");
        }
    }
}
