package package1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LogoutServlet", urlPatterns = { "/LogoutServlet" })
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session to log the user out
        HttpSession session = request.getSession(false); // Get the current session (if it exists)
        if (session != null) {
            session.invalidate(); // Invalidate the session to clear all session attributes
        }

        // Set response content type to HTML
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Write JavaScript to display an alert box and redirect to the login page
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Logout</title>");
        out.println("<script type=\"text/javascript\">");
        out.println("alert('You have been logged out successfully!');");
        out.println("window.location.href = 'Login.jsp';"); // Redirect to Login.jsp after the alert
        out.println("</script>");
        out.println("</head>");
        out.println("<body>");
        out.println("</body>");
        out.println("</html>");
    }
}