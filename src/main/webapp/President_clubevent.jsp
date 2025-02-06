<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Events</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            color: #333;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #fff;
        }
        .event-container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .event-info {
            margin-bottom: 15px;
        }
        .event-info label {
            font-weight: bold;
            color: #4caf50;
        }
        .back-button {
            display: block;
            width: 100px;
            margin: 20px auto;
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
        }
        .back-button:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        table th {
            background-color: #4caf50;
            color: white;
        }
        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
<script id="replace_with_presidentnavbar" src="presidentnavbar.js"></script>
    <h1>Club Events</h1>
    <%
        String studentId = (String) session.getAttribute("Student_ID");
        if (studentId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String clubIdParam = request.getParameter("Club_ID");
        if (clubIdParam == null || clubIdParam.isEmpty()) {
            response.sendRedirect("President_home.jsp");
            return;
        }

        int clubId = Integer.parseInt(clubIdParam);

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            // Query to check if the logged-in student is the president of the club
            String query = "SELECT e.Event_ID, e.Event_Name, e.Event_Date, e.Event_Desc, e.Event_Location, e.Event_Status " +
                           "FROM event e " +
                           "JOIN club c ON e.Club_ID = c.Club_ID " +
                           "WHERE c.Club_ID = ? AND c.President_ID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, clubId);
            pst.setString(2, studentId);
            rs = pst.executeQuery();

            if (!rs.isBeforeFirst()) { // No events found for this club
                out.println("<div class='event-container'><p>No events available for this club.</p></div>");
            } else {
    %>

    <%-- ✅ Prevent Caching --%>
    <%
        // Set HTTP headers to prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies

        // Validate Session
        if (session == null || session.getAttribute("Student_ID") == null) {
            response.sendRedirect("Login.jsp"); // Redirect if session is invalid
            return;
        }

        // Retrieve session attributes
        String studentName = (String) session.getAttribute("Name");

        // Ensure name is not null
        if (studentName == null) {
            studentName = "Guest";
        }
    %>

    <div class="event-container">
        <table>
            <thead>
                <tr>
                    <th>Event Name</th>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Location</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        int eventId = rs.getInt("Event_ID");
                        String eventName = rs.getString("Event_Name");
                        String eventDate = rs.getDate("Event_Date").toString();
                        String eventDesc = rs.getString("Event_Desc");
                        String eventLocation = rs.getString("Event_Location");
                        String eventStatus = rs.getString("Event_Status");
                %>
                <tr>
                    <td><%= eventName %></td>
                    <td><%= eventDate %></td>
                    <td><%= eventDesc.length() > 50 ? eventDesc.substring(0, 50) + "..." : eventDesc %></td>
                    <td><%= eventLocation %></td>
                    <td><%= eventStatus %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
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
    <a href="President_home.jsp" class="back-button">Back to Dashboard</a>
</body>
</html>