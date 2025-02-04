<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Events</title>
    <link rel="icon" type="image/x-icon"
    href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right,  #4facfe, #00f2fe);
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
            margin-bottom: 20px;
        }
        .event-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .event-title {
            font-size: 24px;
            font-weight: bold;
            color: #ff7e5f;
        }
        .event-date {
            font-size: 16px;
            color: #666;
        }
        .event-description {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 10px;
        }
        .event-buttons {
            text-align: center;
        }
        .event-button {
            background-color: #ff7e5f;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
            text-decoration: none;
        }
        .event-button:hover {
            background-color: #ff5c38;
        }
        .no-events {
            color: red;
            text-align: center;
            font-size: 16px;
        }
    </style>
</head>
<body>

<%-- ✅ Prevent Caching --%>
<%
    // Set HTTP headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies
%>

    <script id="replace_with_navbar" src="nav.js"></script>
    <h1>Upcoming Club Events</h1>
    <%
        String studentId = (String) session.getAttribute("Student_ID");
        if (studentId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        boolean hasEvents = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // Fetch all events for clubs
            String query = "SELECT e.Event_ID, e.Event_Name, e.Event_Date, e.Event_Desc, c.Club_Name FROM event e JOIN club c ON e.Club_ID = c.Club_ID ORDER BY e.Event_Date ASC";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
    %>
    <%
            while (rs.next()) {
                hasEvents = true;
    %>
    <div class="event-container">
        <div class="event-header">
            <div class="event-title"><%= rs.getString("Event_Name") %></div>
            <div class="event-date"><%= rs.getDate("Event_Date") %></div>
        </div>
        <div class="event-description">
            <%= rs.getString("Event_Desc").length() > 100 ? rs.getString("Event_Desc").substring(0, 100) + "..." : rs.getString("Event_Desc") %>
        </div>
        <div class="event-buttons">
            <a href="vieweventdetails.jsp?Event_ID=<%= rs.getInt("Event_ID") %>" class="event-button">View Details</a>
        </div>
    </div>
    <%
            }
            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!hasEvents) {
    %>
    <div class="no-events">No upcoming events are currently available.</div>
    <%
        }
    %>
</body>
</html>