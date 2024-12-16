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

@WebServlet(name = "UpdatePasswordServlet", urlPatterns = { "/UpdatePasswordServlet" })
public class UpdatePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lastEmail = request.getParameter("lastEmail");
        String icDigits = request.getParameter("icDigits");
        String phoneNumber = request.getParameter("phoneNumber");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Ensure the passwords match
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("ResetPassword.jsp?message=Passwords do not match.");
            return;
        }

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/clubmanagementsystem";
        String dbUser = "root";
        String dbPassword = "root";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                // Validate the email, IC number, and phone number
                String validateSql = "SELECT * FROM student WHERE Email = ? AND SUBSTRING(IC_Num, -4) = ? AND Contact_Num = ?";
                try (PreparedStatement validatePst = con.prepareStatement(validateSql)) {
                    validatePst.setString(1, lastEmail);
                    validatePst.setString(2, icDigits);
                    validatePst.setString(3, phoneNumber);

                    try (ResultSet rs = validatePst.executeQuery()) {
                        if (rs.next()) {
                            // Update the password
                            String updateSql = "UPDATE student SET Password = ? WHERE Email = ?";
                            try (PreparedStatement updatePst = con.prepareStatement(updateSql)) {
                                updatePst.setString(1, newPassword);
                                updatePst.setString(2, lastEmail);

                                int rowsUpdated = updatePst.executeUpdate();
                                if (rowsUpdated > 0) {
                                    response.sendRedirect("Login.jsp?message=Password updated successfully!");
                                } else {
                                    response.sendRedirect("ResetPassword.jsp?message=Failed to update password.");
                                }
                            }
                        } else {
                            response.sendRedirect("ResetPassword.jsp?message=Invalid details provided.");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ResetPassword.jsp?message=An error occurred. Please try again.");
        }
    }
}
