<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Dashboard</title>
    <link rel="icon" type="image/x-icon"
        href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
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
    String studentId = (String) session.getAttribute("Student_ID");
    String studentName = (String) session.getAttribute("Name");

    // Ensure name is not null
    if (studentName == null) {
        studentName = "Guest";
    }
%>
    <div class="welcome">
        <h1>Welcome, <%= studentName %>!</h1>
        <p>What would you like to do today?</p>
    </div>

    <!-- ✅ Slideshow Container for Upcoming Events -->
    <div class="slideshow-container">
        <%
            String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
            String DB_USER = "u9946_Kmmw1Vvrcg";
            String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            boolean hasEvents = false;

            try {
                // Use the correct MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                String query = "SELECT Event_ID, Event_Name, Event_Desc, Event_Date FROM event WHERE Event_Status = ? ORDER BY Event_Date ASC LIMIT 3";
                pst = con.prepareStatement(query);
                pst.setString(1, "Scheduled"); // Prevent SQL Injection
                rs = pst.executeQuery();

                while (rs.next()) {
                    hasEvents = true;
                    int eventId = rs.getInt("Event_ID");
                    String eventName = rs.getString("Event_Name");
                    String eventDesc = rs.getString("Event_Desc");
                    java.sql.Date eventDate = rs.getDate("Event_Date");
        %>
        <div class="card">
            <h3><%= eventName %></h3>
            <p><%= eventDesc.length() > 100 ? eventDesc.substring(0, 100) + "..." : eventDesc %></p>
            <p><strong>Date:</strong> <%= eventDate %></p>
            <a href="vieweventdetails.jsp?Event_ID=<%= eventId %>">View Details</a>
        </div>
        <%
                }
            } catch (Exception e) {
                // Log the error instead of printing stack trace
                System.err.println("Database Error: " + e.getMessage());
            } finally {
                // Properly close resources
                try { if (rs != null) rs.close(); } catch (SQLException e) { /* Ignored */ }
                try { if (pst != null) pst.close(); } catch (SQLException e) { /* Ignored */ }
                try { if (con != null) con.close(); } catch (SQLException e) { /* Ignored */ }
            }

            if (!hasEvents) {
        %>
        <div class="card">
            <h3>No Upcoming Events</h3>
            <p>Stay tuned for future updates!</p>
        </div>
        <%
            }
        %>
    </div>

    <div class="cards">
        <div class="card">
            <h3>View Clubs</h3>
            <p>Explore all the clubs available at your university.</p>
            <a href="viewclub.jsp">Go to Clubs</a>
        </div>
        <div class="card">
            <h3>Apply for a Club</h3>
            <p>Join a new club that matches your interests.</p>
            <a href="ApplyClub.jsp">Apply Now</a>
        </div>
        <div class="card">
            <h3>Events</h3>
            <p>Stay updated on upcoming events and activities.</p>
            <a href="Event.jsp">View Events</a>
        </div>
        <div class="card">
            <h3>My Profile</h3>
            <p>View and update your profile information.</p>
            <a href="Profile.jsp">Go to Profile</a>
        </div>
    </div>
</body>
</html>