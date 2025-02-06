package package1;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CreateEvent", urlPatterns = {"/CreateEvent"})
public class CreateEvent extends HttpServlet {
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

        // Retrieve the existing session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Student_ID") == null || session.getAttribute("Club_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Get parameters from the request
        String eventName = request.getParameter("eventName");
        String eventDate = request.getParameter("eventDate");
        String eventDesc = request.getParameter("eventDesc");
        String eventLocation = request.getParameter("eventLocation");
        Integer clubId = (Integer) session.getAttribute("Club_ID");

        // Validate input
        if (eventName == null || eventName.trim().isEmpty() || 
            eventDate == null || eventDate.trim().isEmpty() || 
            eventDesc == null || eventDesc.trim().isEmpty() || 
            eventLocation == null || eventLocation.trim().isEmpty()) {
            response.getWriter().println("<script>alert('All fields are required. Please fill out the form completely.');window.location.href='CreateEvent.jsp';</script>");
            return;
        }

        // Insert event into the database
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String insertEventQuery = "INSERT INTO event (Event_Name, Event_Date, Event_Desc, Event_Location, Event_Status, Club_ID, Admin_ID) " +
                                      "VALUES (?, ?, ?, ?, 'Upcoming', ?, 1)";
            try (PreparedStatement pst = con.prepareStatement(insertEventQuery)) {
                pst.setString(1, eventName.trim());
                pst.setString(2, eventDate.trim());
                pst.setString(3, eventDesc.trim());
                pst.setString(4, eventLocation.trim());
                pst.setInt(5, clubId);

                int rowsInserted = pst.executeUpdate();
                if (rowsInserted > 0) {
                    response.getWriter().println("<script>alert('Event created successfully!');window.location.href='President_home.jsp';</script>");
                } else {
                    response.getWriter().println("<script>alert('Failed to create the event. Please try again later.');window.location.href='CreateEvent.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error occurred: " + e.getMessage() + "');window.location.href='CreateEvent.jsp';</script>");
        }
    }
}
