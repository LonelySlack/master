<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(to right, #4facfe, #00f2fe); color: #333; margin: 0; padding: 20px; }
        h1 { text-align: center; color: #fff; }
        .event-container { width: 80%; margin: 0 auto; background-color: #fff; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); padding: 20px; }
        .event-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .event-title { font-size: 24px; font-weight: bold; color: #ff7e5f; }
        .event-date { font-size: 16px; color: #666; }
        .event-details { margin-bottom: 10px; }
        .event-details label { font-weight: bold; color: #ff7e5f; }
        .event-button { background-color: #ff7e5f; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; margin: 5px; text-decoration: none; }
        .event-button:hover { background-color: #ff5c38; }
        .no-spots { color: red; font-weight: bold; }
        .back-button { display: block; width: 100px; margin: 20px auto; background-color: #ff7e5f; color: white; border: none; padding: 10px; border-radius: 5px; text-align: center; text-decoration: none; }
        .back-button:hover { background-color: #ff5c38; }
    </style>
</head>
<body>
    <script id="replace_with_navbar" src="nav.js"></script>
    <h1>Event Details</h1>

    <%
        // ✅ Secure session handling
        String studentId = (String) session.getAttribute("Student_ID");
        if (studentId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // ✅ Get Event_ID from URL
        String eventIdParam = request.getParameter("Event_ID");
        if (eventIdParam == null || eventIdParam.isEmpty()) {
            response.sendRedirect("ClubEvents.jsp");
            return;
        }
        int eventId = Integer.parseInt(eventIdParam);

        // ✅ Database connection
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean isAlreadyRegistered = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            // ✅ Check if student is already registered
            String checkRegistrationQuery = "SELECT * FROM student_event WHERE Student_ID = ? AND Event_ID = ?";
            pst = con.prepareStatement(checkRegistrationQuery);
            pst.setString(1, studentId);
            pst.setInt(2, eventId);
            rs = pst.executeQuery();
            if (rs.next()) {
                isAlreadyRegistered = true;
            }
            rs.close();
            pst.close();

            // ✅ Fetch event details
            String query = "SELECT Event_Name, Event_Date, Event_Desc, Event_Location, Event_Status, IFNULL(Number_Joining, 0) AS Number_Joining, IFNULL(Max_Participants, 100) AS Max_Participants FROM event WHERE Event_ID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, eventId);
            rs = pst.executeQuery();

            if (rs.next()) {
                String eventName = rs.getString("Event_Name");
                String eventDate = rs.getDate("Event_Date").toString();
                String eventDesc = rs.getString("Event_Desc");
                String eventLocation = rs.getString("Event_Location");
                String eventStatus = rs.getString("Event_Status");
                int numberJoining = rs.getInt("Number_Joining");
                int maxParticipants = rs.getInt("Max_Participants");

                boolean isFull = numberJoining >= maxParticipants;
                boolean isClosed = !eventStatus.equalsIgnoreCase("Approved");
    %>

    <div class="event-container">
        <div class="event-header">
            <div class="event-title"><%= eventName %></div>
            <div class="event-date"><%= eventDate %></div>
        </div>
        <div class="event-details">
            <label>Description:</label>
            <span><%= eventDesc %></span>
        </div>
        <div class="event-details">
            <label>Location:</label>
            <span><%= eventLocation %></span>
        </div>
        <div class="event-details">
            <label>Status:</label>
            <span><%= eventStatus %></span>
        </div>
        <div class="event-details">
            <label>Registered Participants:</label>
            <span><%= numberJoining %> / <%= maxParticipants %></span>
        </div>

        <div class="event-buttons">
            <%
                if (isClosed) {
            %>
            <div class="event-details no-spots">This event is closed for registration.</div>
            <%
                } else if (isFull) {
            %>
            <div class="event-details no-spots">Registration is full. No more spots available.</div>
            <%
                } else if (isAlreadyRegistered) {
            %>
            <div class="event-details no-spots">You have already joined this event.</div>
            <%
                } else {
            %>
            <form action="RegisterForEventServlet" method="post">
                <input type="hidden" name="Event_ID" value="<%= eventId %>">
                <button type="submit" class="event-button">Join Event</button>
            </form>
            <%
                }
            %>
        </div>
    </div>

    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
    %>

    <a href="Event.jsp" class="back-button">Back to Events</a>
</body>
</html>
