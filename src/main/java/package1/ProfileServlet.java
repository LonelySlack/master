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

@WebServlet(name = "ProfileServlet", urlPatterns = { "/ProfileServlet" })
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("student_id");

        if ("update".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contactNumber");
            String faculty = request.getParameter("faculty");
            String program = request.getParameter("program");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                    String sql = "UPDATE student SET Name = ?, Email = ?, Contact_Num = ?, Faculty = ?, Program = ? WHERE Student_ID = ?";
                    try (PreparedStatement pst = con.prepareStatement(sql)) {
                        pst.setString(1, name);
                        pst.setString(2, email);
                        pst.setString(3, contactNumber);
                        pst.setString(4, faculty);
                        pst.setString(5, program);
                        pst.setString(6, studentId);

                        int rowsUpdated = pst.executeUpdate();
                        if (rowsUpdated > 0) {
                            response.sendRedirect("Profile.jsp?message=Profile updated successfully!");
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("UpdateProfile.jsp?error=An error occurred. Please try again.");
            }
        }
    }
}
