package package1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginServlet", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        String studentId = request.getParameter("Student_ID").trim();
        String password = request.getParameter("Password").trim();
        String role = request.getParameter("Role");

        String dbURL = "jdbc:mysql://localhost:3306/clubmanagementsystem";
        String dbUser = "root";
        String dbPassword = "root";

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish database connection
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                // SQL query to validate credentials and fetch user details
                String sql = "SELECT s.Name, c.Club_ID FROM student s " +
                             "LEFT JOIN club c ON s.Student_ID = c.President_ID " +
                             "WHERE s.Student_ID = ? AND s.Password = ?";
                try (PreparedStatement pst = con.prepareStatement(sql)) {
                    pst.setString(1, studentId);
                    pst.setString(2, password);

                    try (ResultSet rs = pst.executeQuery()) {
                        if (rs.next()) {
                            // Fetch user name and club ID
                            String studentName = rs.getString("Name");
                            Integer clubId = rs.getInt("Club_ID");

                            // Set session attributes
                            request.getSession().setAttribute("Student_ID", studentId);
                            request.getSession().setAttribute("Student_Name", studentName);

                            if ("Club President".equals(role)) {
                                if (clubId != null && clubId > 0) {
                                    request.getSession().setAttribute("Club_ID", clubId);
                                    response.sendRedirect("welcomePresident.jsp");
                                } else {
                                    // No club assigned
                                    request.setAttribute("errorMessage", "You are not assigned as a president for any club.");
                                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                                }
                            } else if ("General Member".equals(role)) {
                                response.sendRedirect("welcome.jsp");
                            } else {
                                // Invalid role
                                request.setAttribute("errorMessage", "Invalid role selected.");
                                request.getRequestDispatcher("Login.jsp").forward(request, response);
                            }
                        } else {
                            // Invalid credentials
                            request.getSession().invalidate(); // Clear session
                            request.setAttribute("errorMessage", "Invalid Student ID or Password.");
                            request.getRequestDispatcher("Login.jsp").forward(request, response);
                        }
                    }
                }
            }
        } catch (Exception e) {
            // Log exception and redirect to error page
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
