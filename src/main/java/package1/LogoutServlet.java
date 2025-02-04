package package1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = { "/LogoutServlet" })
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session to log the user out
        HttpSession session = request.getSession(false); // Get the current session (if it exists)
        if (session != null) {
            session.invalidate(); // Invalidate the session to clear all session attributes
        }

        // Redirect the user to the login page after logout
        response.sendRedirect("Login.jsp?message=You have been logged out successfully!");
    }
}