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
        String email = request.getParameter("email");
        String contactNum = request.getParameter("cont_num");
        String faculty = request.getParameter("faculty");
        String program = request.getParameter("program");
        String password = request.getParameter("password");

        // Log form data for debugging
        System.out.println("Student ID: " + studentId);
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Contact Number: " + contactNum);
        System.out.println("Faculty: " + faculty);
        System.out.println("Program: " + program);
        System.out.println("Password: " + password);

        Connection con = null;
        PreparedStatement pstStudent = null;
        PreparedStatement pstClubMember = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // Insert query for Student table
            String sqlStudent = "INSERT INTO Student (Student_ID, Name, Email, Contact_Num, Faculty, Program, Status, Password) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstStudent = con.prepareStatement(sqlStudent);
            pstStudent.setString(1, studentId);
            pstStudent.setString(2, name);
            pstStudent.setString(3, email);
            pstStudent.setString(4, contactNum);
            pstStudent.setString(5, faculty);
            pstStudent.setString(6, program);
            pstStudent.setString(7, "Active"); // Default status
            pstStudent.setString(8, password); // For production, hash this password

            int rowsInsertedStudent = pstStudent.executeUpdate();

            if (rowsInsertedStudent > 0) {
                // Insert query for Club_Member table
                String sqlClubMember = "INSERT INTO Club_Member (Student_ID, Club_ID, Member_Status, Register_Date, Role_ID) " +
                                       "VALUES (?, ?, ?, CURDATE(), ?)";
                pstClubMember = con.prepareStatement(sqlClubMember);

                // Use valid default values for Club_ID and Role_ID
                int clubId = 1; // Replace with a valid club ID
                int roleId = 2; // Replace with a valid role ID for "Member"

                pstClubMember.setString(1, studentId);
                pstClubMember.setInt(2, clubId);
                pstClubMember.setString(3, "Active"); // Default member status
                pstClubMember.setInt(4, roleId);

                int rowsInsertedClubMember = pstClubMember.executeUpdate();

                if (rowsInsertedClubMember > 0) {
                    // Success message
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Sign Up Successful!');");
                    out.println("window.location.href = 'Login.jsp';");
                    out.println("</script>");
                } else {
                    // Failure message
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Error during sign up (Club Member). Please try again.');");
                    out.println("window.location.href = 'Signup.jsp';");
                    out.println("</script>");
                }
            } else {
                // Failure message
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error during sign up (Student). Please try again.');");
                out.println("window.location.href = 'Signup.jsp';");
                out.println("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
            out.println("<pre>");
            e.printStackTrace(out); // Print stack trace to the response
            out.println("</pre>");
        } finally {
            try {
                if (pstStudent != null) pstStudent.close();
                if (pstClubMember != null) pstClubMember.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        out.close();
    }
}