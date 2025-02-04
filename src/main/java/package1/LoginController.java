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

    private static final String DB_URL = "jdbc:mysql://localhost:3306/clubmanagementsystem?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String studentId = request.getParameter("Student_ID");
        String password = request.getParameter("Password");
        String role = request.getParameter("Role");

        try {
            // ✅ Load MySQL JDBC Driver for Connector/J 8.0+
            Class.forName("com.mysql.jdbc.Driver");

            // ✅ Establish Database Connection
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT s.Name, c.Club_ID, r.Role_Name FROM Student s " +
                             "JOIN Club_Member cm ON s.Student_ID = cm.Student_ID " +
                             "JOIN Role r ON cm.Role_ID = r.Role_ID " +
                             "LEFT JOIN Club c ON cm.Club_ID = c.Club_ID " +
                             "WHERE s.Student_ID = ? AND s.Password = ? AND r.Role_Name = ? AND cm.Member_Status = 'Active'";

                try (PreparedStatement pst = con.prepareStatement(sql)) {
                    pst.setString(1, studentId);
                    pst.setString(2, password);
                    pst.setString(3, role);

                    try (ResultSet rs = pst.executeQuery()) {
                        if (rs.next()) {
                            User user = new User();
                            user.setStudentId(studentId);
                            user.setName(rs.getString("Name"));
                            user.setClubId(rs.getInt("Club_ID"));
                            user.setRole(rs.getString("Role_Name"));

                            HttpSession session = request.getSession();
                            session.setAttribute("Student_ID", studentId);
                            session.setAttribute("User", user);

                            if ("President".equals(role) && user.getClubId() != null) {
                                out.println("<script type='text/javascript'>");
                                out.println("alert('Login Successful! Welcome " + user.getName() + "');");
                                out.println("window.location.href = 'welcomeAdmin.jsp';");
                                out.println("</script>");
                            } else if ("Member".equals(role)) {
                                out.println("<script type='text/javascript'>");
                                out.println("alert('Login Successful! Welcome " + user.getName() + "');");
                                out.println("window.location.href = 'welcome.jsp';");
                                out.println("</script>");
                            } else {
                                out.println("<script type='text/javascript'>");
                                out.println("alert('You do not have the required role for this action.');");
                                out.println("window.location.href = 'Login.jsp';");
                                out.println("</script>");
                            }
                        } else {
                            out.println("<script type='text/javascript'>");
                            out.println("alert('Invalid Student ID, Password, or Role. Please try again.');");
                            out.println("window.location.href = 'Login.jsp';");
                            out.println("</script>");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            out.println("<h3>❌ Database Driver Not Found! Ensure mysql-connector-java is in the classpath.</h3>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<h3>❌ Database Connection Error! Check JDBC URL, MySQL Server, and Credentials.</h3>");
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}
