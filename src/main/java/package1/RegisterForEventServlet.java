package package1;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterForEventServlet", urlPatterns = {"/RegisterForEventServlet"})
public class RegisterForEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
    private static final String DB_USER = "u9946_Kmmw1Vvrcg";
    private static final String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

    static {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Secure session handling
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Student_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("Student_ID");
        String eventIdStr = request.getParameter("Event_ID");

        // Validate inputs
        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            response.getWriter().println("<script>alert('Invalid event ID.');window.location.href='Event.jsp';</script>");
            return;
        }

        int eventId;
        try {
            eventId = Integer.parseInt(eventIdStr.trim());
        } catch (NumberFormatException e) {
            response.getWriter().println("<script>alert('Invalid event ID format.');window.location.href='Event.jsp';</script>");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check if the student is already registered
            String checkRegistrationQuery = "SELECT * FROM student_event WHERE Student_ID = ? AND Event_ID = ?";
            pst = con.prepareStatement(checkRegistrationQuery);
            pst.setString(1, studentId);
            pst.setInt(2, eventId);
            rs = pst.executeQuery();

            if (rs.next()) {
                response.getWriter().println("<script>alert('You have already joined this event.');window.location.href='vieweventdetails.jsp?Event_ID=" + eventId + "';</script>");
                return;
            }
            rs.close();
            pst.close();

            // Fetch current number of participants and max participants
            String fetchEventDetailsQuery = "SELECT Number_Joining, Max_Participants FROM event WHERE Event_ID = ?";
            pst = con.prepareStatement(fetchEventDetailsQuery);
            pst.setInt(1, eventId);
            rs = pst.executeQuery();

            if (!rs.next()) {
                response.getWriter().println("<script>alert('Event not found.');window.location.href='Event.jsp';</script>");
                return;
            }

            int numberJoining = rs.getInt("Number_Joining");
            int maxParticipants = rs.getInt("Max_Participants");
            rs.close();
            pst.close();

            if (numberJoining >= maxParticipants) {
                response.getWriter().println("<script>alert('Registration is full. No more spots available.');window.location.href='vieweventdetails.jsp?Event_ID=" + eventId + "';</script>");
                return;
            }

            // Increment the number of participants
            String updateParticipantsQuery = "UPDATE event SET Number_Joining = Number_Joining + 1 WHERE Event_ID = ?";
            pst = con.prepareStatement(updateParticipantsQuery);
            pst.setInt(1, eventId);
            pst.executeUpdate();
            pst.close();

            // Insert the student into the student_event table with Join_Date
            String insertRegistrationQuery = "INSERT INTO student_event (Student_ID, Event_ID, Join_Date) VALUES (?, ?, ?)";
            pst = con.prepareStatement(insertRegistrationQuery);
            pst.setString(1, studentId);
            pst.setInt(2, eventId);
            pst.setDate(3, Date.valueOf(LocalDate.now())); // ✅ Fix: Set Join_Date to today's date
            pst.executeUpdate();
            pst.close();

            // Check if the event is now full and close it
            if (numberJoining + 1 >= maxParticipants) {
                String closeEventQuery = "UPDATE event SET Event_Status = 'Closed' WHERE Event_ID = ?";
                pst = con.prepareStatement(closeEventQuery);
                pst.setInt(1, eventId);
                pst.executeUpdate();
            }

            response.getWriter().println("<script>alert('You have successfully joined the event!');window.location.href='vieweventdetails.jsp?Event_ID=" + eventId + "';</script>");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error: " + e.getMessage() + "');window.location.href='vieweventdetails.jsp';</script>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
