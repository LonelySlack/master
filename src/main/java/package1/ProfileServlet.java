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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve action parameter to determine the operation
        String action = request.getParameter("action");

        // Ensure the action is "update"
        if ("update".equals(action)) {
            // Fetch updated details from the form
            String studentId = request.getParameter("Student_ID");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contactNumber");
            String faculty = request.getParameter("faculty");
            String program = request.getParameter("program");
            String status = request.getParameter("status");
            String password = request.getParameter("password");


            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/clubmanagementsystem";
            String dbUser = "root";
            String dbPassword = "root";

            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class name

                // Establish database connection
                try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                    // Prepare SQL query to update student details
                	
                	// Update SQL query
                	String sql = "UPDATE student SET Name = ?, Email = ?, Contact_Num = ?, Faculty = ?, Program = ?, Status = ?, Password = ? WHERE Student_ID = ?";
                	try (PreparedStatement pst = con.prepareStatement(sql)) {
                	    pst.setString(1, name);
                	    pst.setString(2, email);
                	    pst.setString(3, contactNumber);
                	    pst.setString(4, faculty);
                	    pst.setString(5, program);
                	    pst.setString(6, status);
                	    pst.setString(7, password);
                	    pst.setString(8, studentId);

                	    int rowsUpdated = pst.executeUpdate();
                	    if (rowsUpdated > 0) {
                	        // Update session attributes
                	        request.getSession().setAttribute("Student_Name", name);
                	        request.getSession().setAttribute("Email", email);
                	        request.getSession().setAttribute("Contact_Num", contactNumber);
                	        request.getSession().setAttribute("Faculty", faculty);
                	        request.getSession().setAttribute("Program", program);
                	        request.getSession().setAttribute("Status", status);
                	        request.getSession().setAttribute("Password", password);

                	        response.sendRedirect("Profile.jsp?message=Profile updated successfully!");
                	    } else {
                	        response.sendRedirect("UpdateProfile.jsp?error=Failed to update profile. Please try again.");
                	    }
                	}
                    }
                }
             catch (Exception e) {
                // Log the exception and redirect to UpdateProfile.jsp with an error message
                e.printStackTrace();
                response.sendRedirect("UpdateProfile.jsp?error=An error occurred. Please try again.");
            }
        } else {
            // Redirect to UpdateProfile.jsp if the action is not recognized
            response.sendRedirect("UpdateProfile.jsp?error=Invalid action. Please try again.");
        }
    }
}