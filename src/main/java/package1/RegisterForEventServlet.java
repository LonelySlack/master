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
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterForEventServlet")
public class RegisterForEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve session and student ID
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Student_ID") == null) {
            response.sendRedirect("Login.jsp"); // Redirect to login if not logged in
            return;
        }

        String studentId = (String) session.getAttribute("Student_ID");

        // Retrieve event ID from the form
        int eventId = Integer.parseInt(request.getParameter("Event_ID"));

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // Check if the event exists and is open for registration
            String checkEventQuery = "SELECT Event_Status, Number_Joinning, Max_Participants FROM event WHERE Event_ID = ?";
            pst = con.prepareStatement(checkEventQuery);
            pst.setInt(1, eventId);
            rs = pst.executeQuery();

            if (rs.next()) {
                String eventStatus = rs.getString("Event_Status");
                int numberJoining = rs.getInt("Number_Joinning");
                int maxParticipants = rs.getInt("Max_Participants");

                // Check if the event is closed or full
                if (!eventStatus.equalsIgnoreCase("Scheduled")) {
                    response.sendRedirect("ViewEventDetails.jsp?Event_ID=" + eventId + "&error=EventClosed");
                    return;
                }
                if (numberJoining >= maxParticipants) {
                    response.sendRedirect("ViewEventDetails.jsp?Event_ID=" + eventId + "&error=EventFull");
                    return;
                }

                // Check if the user is already registered for the event
                String checkRegistrationQuery = "SELECT COUNT(*) AS Registration_Count FROM registration WHERE Student_ID = ? AND Event_ID = ?";
                pst = con.prepareStatement(checkRegistrationQuery);
                pst.setString(1, studentId);
                pst.setInt(2, eventId);
                rs = pst.executeQuery();

                if (rs.next() && rs.getInt("Registration_Count") > 0) {
                    response.sendRedirect("ViewEventDetails.jsp?Event_ID=" + eventId + "&error=AlreadyRegistered");
                    return;
                }

                // Register the user for the event
                String insertRegistrationQuery = "INSERT INTO registration (Student_ID, Event_ID) VALUES (?, ?)";
                pst = con.prepareStatement(insertRegistrationQuery);
                pst.setString(1, studentId);
                pst.setInt(2, eventId);
                pst.executeUpdate();

                // Update the Number_Joinning column in the event table
                String updateEventQuery = "UPDATE event SET Number_Joinning = Number_Joinning + 1 WHERE Event_ID = ?";
                pst = con.prepareStatement(updateEventQuery);
                pst.setInt(1, eventId);
                pst.executeUpdate();

                // Redirect to the event details page with a success message
                response.sendRedirect("vieweventdetails.jsp?Event_ID=" + eventId + "&success=Registered");
            } else {
                response.sendRedirect("Event.jsp"); // Redirect if event doesn't exist
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ErrorPage.jsp"); // Redirect to an error page in case of exceptions
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}