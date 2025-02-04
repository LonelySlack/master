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

@WebServlet(name = "DeleteProfileServlet", urlPatterns = { "/DeleteProfileServlet" })
public class DeleteProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("student_id");

        if (studentId != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

                String sql = "DELETE FROM student WHERE Student_ID = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, studentId);

                int rowsDeleted = pst.executeUpdate();
                if (rowsDeleted > 0) {
                    // Invalidate session after deletion
                    request.getSession().invalidate();
                    response.sendRedirect("Login.jsp?message=Profile deleted successfully.");
                } else {
                    response.sendRedirect("Profile.jsp?error=Unable to delete profile.");
                }

                pst.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("Profile.jsp?error=An error occurred. Please try again.");
            }
        } else {
            response.sendRedirect("Profile.jsp?error=Invalid request.");
        }
    }
}
