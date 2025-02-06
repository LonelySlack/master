<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>President Dashboard</title>
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
        HttpSession userSession = request.getSession(false);
        if (userSession == null || userSession.getAttribute("Student_ID") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Retrieve session attributes
        String studentId = (String) userSession.getAttribute("Student_ID");
        String studentName = (String) userSession.getAttribute("Name");

        // Handle null student name
        if (studentName == null) {
            studentName = "Guest";
        }

        // Database configuration
        String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
        String DB_USER = "u9946_Kmmw1Vvrcg";
        String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        String clubName = "";
        int clubId = -1;

        try {
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Query to get the club details where the president is the logged-in user
            String clubQuery = "SELECT Club_ID, Club_Name FROM club WHERE President_ID = ?";
            pst = con.prepareStatement(clubQuery);
            pst.setString(1, studentId);
            rs = pst.executeQuery();

            if (rs.next()) {
                clubId = rs.getInt("Club_ID");
                clubName = rs.getString("Club_Name");
            } else {
                response.sendRedirect("AccessDenied.jsp");
                return;
            }
        } catch (Exception e) {
            System.err.println("Database Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { /* Ignored */ }
            try { if (pst != null) pst.close(); } catch (SQLException e) { /* Ignored */ }
            try { if (con != null) con.close(); } catch (SQLException e) { /* Ignored */ }
        }
    %>
    <div class="welcome">
        <h1>Welcome, <%= studentName %>!</h1>
        <p>You are the president of <strong><%= clubName %></strong>. What would you like to do today?</p>
    </div>

    <!-- ✅ Actionable Cards -->
    <div class="cards">
        <!-- Club Management -->
        <div class="card">
            <h3>View Club Details</h3>
            <p>View detailed information about your club.</p>
            <a href="view_club.jsp?Club_ID=<%= clubId %>">View Club</a>
        </div>
        <div class="card">
            <h3>View Club Members</h3>
            <p>Manage and view members of your club.</p>
            <a href="view_members.jsp?Club_ID=<%= clubId %>">View Members</a>
        </div>
        <div class="card">
            <h3>Create Event</h3>
            <p>Create a new event for your club.</p>
            <a href="create_event.jsp?Club_ID=<%= clubId %>">Create Event</a>
        </div>
        <div class="card">
            <h3>View Events</h3>
            <p>View all events organized by your club.</p>
            <a href="view_events.jsp?Club_ID=<%= clubId %>">View Events</a>
        </div>
    </div>
</body>
</html>