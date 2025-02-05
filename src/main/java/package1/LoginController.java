package package1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
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

        String studentId = request.getParameter("Student_ID");
        String password = request.getParameter("Password");

        String sql = "SELECT s.Name, cm.Role_ID " +
                     "FROM student s " +
                     "LEFT JOIN club_member cm ON s.Student_ID = cm.Student_ID " +
                     "WHERE s.Student_ID = ? AND s.Password = ? AND (cm.Member_Status = 'Active' OR cm.Member_Status IS NULL)";

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, studentId);
            pst.setString(2, password);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("Name");
                    int roleId = rs.getInt("Role_ID");

                    HttpSession session = request.getSession();
                    session.setAttribute("Student_ID", studentId);
                    session.setAttribute("Name", name);
                    session.setAttribute("Role_ID", roleId);

                    // Redirect based on Role_ID
                    if (roleId == 1) {
                        response.sendRedirect("welcomePresident.jsp"); // Admin
                    } else {
                        response.sendRedirect("welcome.jsp"); // Other roles or no role
                    }
                } else {
                    showAlert(response, "Invalid Student ID or Password! Please try again.", "Login.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            showAlert(response, "Database Connection Error! Please contact the administrator.", "Login.jsp");
        }
    }

    private void showAlert(HttpServletResponse response, String message, String redirectPage) throws IOException {
        PrintWriter out = response.getWriter();
        out.println("<script type='text/javascript'>");
        out.println("alert('" + message + "');");
        out.println("window.location.href = '" + redirectPage + "';");
        out.println("</script>");
        out.close();
    }
}
