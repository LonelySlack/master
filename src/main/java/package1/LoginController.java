package package1;

import java.io.IOException;



import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Use the provided database credentials
    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    static {
        try {
            // Register the MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");  // Correct MySQL driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("MySQL JDBC Driver not found.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String studentId = request.getParameter("Student_ID");
        String password = request.getParameter("Password");

        // SQL query to check if credentials are valid
        String sql = "SELECT Name FROM student WHERE Student_ID = ? AND Password = ?";

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pst = con.prepareStatement(sql)) 
        {

   //test         // Set query parameters
            pst.setString(1, studentId);
            pst.setString(2, password);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    // Create session and store user information
                    HttpSession session = request.getSession();
                    session.setAttribute("Student_ID", studentId);
                    session.setAttribute("Name", rs.getString("Name"));

                    // Redirect to welcome page
                    response.sendRedirect("welcome.jsp");
                } else {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('❌ Invalid Student ID or Password! Please try again.');");
                    out.println("window.location.href = 'Login.jsp';");
                    out.println("</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h3>❌ Database Connection Error!</h3>");
        }
        out.close();
    }
}