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
        String studentid = request.getParameter("student_id");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Ensure the passwords match
        if (!newPassword.equals(confirmPassword)) {
            showAlertAndRedirect(response, "Passwords do not match.", "ResetPassword.jsp");
            return;
        }

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/clubmanagementsystem";
        String dbUser = "root";
        String dbPassword = "root";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                // Validate the email and student ID
                String validateSql = "SELECT * FROM student WHERE Email = ? AND Student_ID = ?";
                try (PreparedStatement validatePst = con.prepareStatement(validateSql)) {
                    validatePst.setString(1, lastEmail);
                    validatePst.setString(2, studentid);
                    try (ResultSet rs = validatePst.executeQuery()) {
                        if (rs.next()) {
                            // Update the password
                            String updateSql = "UPDATE student SET Password = ? WHERE Email = ?";
                            try (PreparedStatement updatePst = con.prepareStatement(updateSql)) {
                                updatePst.setString(1, newPassword);
                                updatePst.setString(2, lastEmail);
                                int rowsUpdated = updatePst.executeUpdate();
                                if (rowsUpdated > 0) {
                                    showAlertAndRedirect(response, "Password updated successfully!", "Login.jsp");
                                } else {
                                    showAlertAndRedirect(response, "Failed to update password.", "ResetPassword.jsp");
                                }
                            }
                        } else {
                            showAlertAndRedirect(response, "Invalid details provided.", "ResetPassword.jsp");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            showAlertAndRedirect(response, "An error occurred. Please try again.", "ResetPassword.jsp");
        }
    }

    /**
     * Helper method to show an alert box and redirect to a specific page.
     *
     * @param response The HttpServletResponse object.
     * @param message  The message to display in the alert box.
     * @param redirectUrl The URL to redirect to after the alert is dismissed.
     * @throws IOException If an I/O error occurs.
     */
    private void showAlertAndRedirect(HttpServletResponse response, String message, String redirectUrl) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<script type='text/javascript'>");
        response.getWriter().println("alert('" + message + "');");
        response.getWriter().println("window.location.href='" + redirectUrl + "';");
        response.getWriter().println("</script>");
    }
}