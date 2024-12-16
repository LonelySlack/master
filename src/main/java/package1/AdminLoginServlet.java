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

@WebServlet(name = "AdminLoginServlet", urlPatterns = { "/AdminLoginServlet" })
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        // Retrieve admin inputs
        String adminID = request.getParameter("Admin_ID");
        String adminPassword = request.getParameter("Admin_Password");

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/clubmanagementsystem";
        String dbUser = "root";
        String dbPassword = "root";

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                // SQL query to validate Admin credentials
                String sql = "SELECT Admin_Name FROM admin WHERE Admin_ID = ? AND Admin_Password = ?";
                try (PreparedStatement pst = con.prepareStatement(sql)) {
                    pst.setString(1, adminID);
                    pst.setString(2, adminPassword);

                    try (ResultSet rs = pst.executeQuery()) {
                        if (rs.next()) {
                            // Retrieve admin name
                            String adminName = rs.getString("Admin_Name");

                            // Store admin info in session
                            request.getSession().setAttribute("Admin_ID", adminID);
                            request.getSession().setAttribute("Admin_Name", adminName);

                            // Redirect to welcomeAdmin.jsp
                            response.sendRedirect("welcomeAdmin.jsp");
                        } else {
                            // Invalid credentials
                            request.setAttribute("errorMessage", "Invalid Admin ID or Password.");
                            request.getRequestDispatcher("LoginAdmin.jsp").forward(request, response);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("LoginAdmin.jsp").forward(request, response);
        }
    }
}
