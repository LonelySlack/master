package package1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ Correct Database Credentials
    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    static {
        try {
            // ✅ Use the correct MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("MySQL JDBC Driver not found.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // ✅ Retrieve form data
        String studentId = request.getParameter("student_id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contactNum = request.getParameter("cont_num");
        String faculty = request.getParameter("faculty");
        String program = request.getParameter("program");
        String icNum = request.getParameter("ic_num");
        String password = request.getParameter("password");

        // ✅ Check if Student_ID already exists
        String checkSql = "SELECT COUNT(*) FROM student WHERE Student_ID = ?";
        String insertSql = "INSERT INTO student (Student_ID, Name, IC_Num, Email, Contact_Num, Faculty, Program, Status, Password) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement checkStmt = con.prepareStatement(checkSql)) {

            // ✅ Check for duplicate Student_ID
            checkStmt.setString(1, studentId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('❌ Error: Student ID already exists! Please use a different Student ID.');");
                    out.println("window.location.href = 'Signup.jsp';");
                    out.println("</script>");
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h1>❌ Database Error: " + e.getMessage() + "</h1>");
            return;
        }

        // ✅ Insert new student record
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement insertStmt = con.prepareStatement(insertSql)) {

            insertStmt.setString(1, studentId);
            insertStmt.setString(2, name);
            insertStmt.setString(3, icNum);
            insertStmt.setString(4, email);
            insertStmt.setString(5, contactNum);
            insertStmt.setString(6, faculty);
            insertStmt.setString(7, program);
            insertStmt.setString(8, "Active");
            insertStmt.setString(9, password);

            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('✅ Sign Up Successful!');");
                out.println("window.location.href = 'Login.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('⚠️ Error during sign up. Please try again.');");
                out.println("window.location.href = 'Signup.jsp';");
                out.println("</script>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h1>❌ Database Error: " + e.getMessage() + "</h1>");
        }

        out.close();
    }
}
