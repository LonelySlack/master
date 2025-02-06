package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterForEventServlet", urlPatterns = {"/RegisterForEventServlet"})
public class RegisterForEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve the session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Student_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("Student_ID");
        String eventIdParam = request.getParameter("Event_ID");

        if (eventIdParam == null || eventIdParam.isEmpty()) {
            response.getWriter().println("<script>alert('Invalid event ID.');window.location.href='Event.jsp';</script>");
            return;
        }

        int eventId = Integer.parseInt(eventIdParam);

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Check if the student is already registered for this event
            String checkQuery = "SELECT * FROM student_event WHERE Student_ID = ? AND Event_ID = ?";
            try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
                checkStmt.setString(1, studentId);
                checkStmt.setInt(2, eventId);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        response.getWriter().println("<script>alert('You are already registered for this event.');window.location.href='Event.jsp';</script>");
                        return;
                    }
                }
            }

            // Register the student for the event
            String registerQuery = "INSERT INTO student_event (Student_ID, Event_ID, Join_Date, Status) VALUES (?, ?, CURDATE(), 'Registered')";
            try (PreparedStatement registerStmt = con.prepareStatement(registerQuery)) {
                registerStmt.setString(1, studentId);
                registerStmt.setInt(2, eventId);

                int rowsInserted = registerStmt.executeUpdate();
                if (rowsInserted > 0) {
                    response.getWriter().println("<script>alert('Successfully registered for the event!');window.location.href='Event.jsp';</script>");
                } else {
                    response.getWriter().println("<script>alert('Failed to register for the event. Please try again.');window.location.href='Event.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error occurred: " + e.getMessage() + "');window.location.href='Event.jsp';</script>");
        }
    }
}
