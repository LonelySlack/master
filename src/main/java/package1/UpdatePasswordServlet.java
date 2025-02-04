package package1;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdatePasswordServlet", urlPatterns = { "/UpdatePasswordServlet" })
public class UpdatePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lastEmail = request.getParameter("lastEmail");
        String studentId = request.getParameter("student_id");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // ✅ Ensure passwords match before proceeding
        if (!newPassword.equals(confirmPassword)) {
            showAlertAndRedirect(response, "❌ Passwords do not match.", "ResetPassword.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver"); // ✅ Use the correct driver

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // ✅ Check if the email and student ID exist
                String validateSql = "SELECT * FROM student WHERE Email = ? AND Student_ID = ?";
                try (PreparedStatement validatePst = con.prepareStatement(validateSql)) {
                    validatePst.setString(1, lastEmail);
                    validatePst.setString(2, studentId);

                    try (ResultSet rs = validatePst.executeQuery()) {
                        if (rs.next()) {
                            // ✅ Update the password
                            String updateSql = "UPDATE student SET Password = ? WHERE Email = ?";
                            try (PreparedStatement updatePst = con.prepareStatement(updateSql)) {
                                updatePst.setString(1, newPassword); // Consider hashing this in the future
                                updatePst.setString(2, lastEmail);

                                int rowsUpdated = updatePst.executeUpdate();
                                if (rowsUpdated > 0) {
                                    showAlertAndRedirect(response, "✅ Password updated successfully!", "Login.jsp");
                                } else {
                                    showAlertAndRedirect(response, "❌ Failed to update password.", "ResetPassword.jsp");
                                }
                            }
                        } else {
                            showAlertAndRedirect(response, "❌ Invalid email or student ID provided.", "ResetPassword.jsp");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            showAlertAndRedirect(response, "❌ An error occurred. Please try again.", "ResetPassword.jsp");
        }
    }

    /**
     * ✅ Helper method to show an alert box and redirect to a specific page.
     */
    private void showAlertAndRedirect(HttpServletResponse response, String message, String redirectUrl) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<script type='text/javascript'>");
        response.getWriter().println("alert('" + message + "');");
        response.getWriter().println("window.location.href='" + redirectUrl + "';");
        response.getWriter().println("</script>");
    }
}
