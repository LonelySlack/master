<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
        }
        .welcome {
            text-align: center;
            margin: 40px 0;
            color: white;
        }
        .welcome h1 {
            font-size: 36px;
        }
        .cards {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 30px;
            flex-wrap: wrap;
        }
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            flex: 1;
            max-width: 300px;
            min-width: 200px;
        }
        .card h3 {
            color: #00f2fe;
            margin-bottom: 10px;
        }
        .card p {
            color: #666;
        }
        .card a {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 15px;
            background: #00f2fe;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease;
        }
        .card a:hover {
            background: #4facfe;
        }
        .slideshow-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 30px;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
    <script id="replace_with_navbar" src="nav.js"></script>
    <%-- ✅ Prevent Caching --%>
    <%
        // Prevent browser caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        // Validate session
        if (session == null || session.getAttribute("Admin_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        // Retrieve session attributes
        String adminId = (String) session.getAttribute("Admin_ID");
        String adminName = (String) session.getAttribute("Admin_Name");
        // Handle null admin name
        if (adminName == null) {
            adminName = "Guest";
        }
    %>
    <div class="welcome">
        <h1>Welcome, <%= adminName %>!</h1>
        <p>What would you like to do today?</p>
    </div>

    <!-- ✅ Actionable Cards -->
    <div class="cards">
        <!-- Club Management -->
        <div class="card">
            <h3>Create New Club</h3>
            <p>Create a new club for students to join.</p>
            <a href="create_club.html">Create Now</a>
        </div>
        <div class="card">
            <h3>Club Application</h3>
            <p>Review and manage club applications.</p>
            <a href="club_application.html">Manage Applications</a>
        </div>
        <div class="card">
            <h3>Club Status</h3>
            <p>Check the status of all clubs.</p>
            <a href="club_status.html">View Status</a>
        </div>
        <div class="card">
            <h3>Club Details</h3>
            <p>View detailed information about each club.</p>
            <a href="club_details.html">View Details</a>
        </div>
        <div class="card">
            <h3>Club Members</h3>
            <p>Manage members of each club.</p>
            <a href="club_member.html">Manage Members</a>
        </div>
        <div class="card">
            <h3>Assign Club President</h3>
            <p>Assign or change the president of a club.</p>
            <a href="assign_president.html">Assign President</a>
        </div>
 		<div class="card">
            <h3>View Club President Application </h3>
            <p>Details the president Application.</p>
            <a href="Applicationpresident.jsp">View Application </a>
        </div>
        <!-- Event Management -->
        <div class="card">
            <h3>Create Event</h3>
            <p>Create a new event for students to attend.</p>
            <a href="create_event.html">Create Now</a>
        </div>
        <div class="card">
            <h3>Event Application</h3>
            <p>Review and manage event applications.</p>
            <a href="Admin_ApproveEvent.jsp">Manage Applications</a>
        </div>
        <div class="card">
            <h3>Event Details</h3>
            <p>View detailed information about each event.</p>
            <a href="event_details.html">View Details</a>
        </div>
    </div>
</body>
</html>