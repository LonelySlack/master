package package1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SignupServlet", urlPatterns = { "/SignupServlet" })
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve data from the form
        String studentId = request.getParameter("student_id");
        String name = request.getParameter("name");
        String ic = request.getParameter("ic");
        String email = request.getParameter("email");
        String contactNum = request.getParameter("cont_num");
        String faculty = request.getParameter("faculty");
        String program = request.getParameter("program");
        String year = request.getParameter("year");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement pst = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // Insert query
            String sql = "INSERT INTO student (Student_ID, Name, IC_Num, Email, Contact_Num, Faculty, Program, Status, Password) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            pst = con.prepareStatement(sql);
            pst.setString(1, studentId);
            pst.setString(2, name);
            pst.setString(3, ic);
            pst.setString(4, email);
            pst.setString(5, contactNum);
            pst.setString(6, faculty);
            pst.setString(7, program);
            pst.setString(8, year);  // Assuming year of study is stored in "Status" column
            pst.setString(9, password); // For production, hash this password

            int rowsInserted = pst.executeUpdate();

            if (rowsInserted > 0) {
                // Success message
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Sign Up Successful!');");
                out.println("window.location.href = 'Login.jsp';");
                out.println("</script>");
            } else {
                // Failure message
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error during sign up. Please try again.');");
                out.println("window.location.href = 'Signup.jsp';");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Database error: " + e.getMessage() + "');");
            out.println("window.location.href = 'Signup.jsp';");
            out.println("</script>");
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        out.close();
    }
}
