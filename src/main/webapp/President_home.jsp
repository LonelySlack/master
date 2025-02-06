<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>President Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333;
            color: white;
            padding: 10px 20px;
        }
        .navbar h1 {
            margin: 0;
        }
        .sidebar {
            width: 250px;
            background-color: #333;
            color: white;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 15px;
            border-bottom: 1px solid #444;
            cursor: pointer;
        }
        .sidebar ul li:hover {
            background-color: #575757;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .section {
            display: none;
        }
        .section.active {
            display: block;
        }
        .card {
            background-color: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .card h2 {
            margin-top: 0;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>President Dashboard</h1>
        <span>Welcome, <%= session.getAttribute("Name") %>!</span>
    </div>
    <div class="sidebar">
        <ul>
            <li onclick="showSection('club')">Club Management</li>
            <li onclick="showSection('event')">Event Management</li>
        </ul>
    </div>
    <div class="main-content">
        <!-- Club Section -->
        <div id="club" class="section active">
            <div class="card">
                <h2>Club Management</h2>
                <button onclick="window.location.href='view_club.jsp'">View Club Details</button>
                <button onclick="window.location.href='view_members.jsp'">View Club Members</button>
            </div>
        </div>

        <!-- Event Section -->
        <div id="event" class="section">
            <div class="card">
                <h2>Event Management</h2>
                <button onclick="window.location.href='create_event.jsp'">Create Event</button>
                <button onclick="window.location.href='view_events.jsp'">View Events</button>
            </div>
        </div>
    </div>

    <script>
        function showSection(sectionId) {
            const sections = document.querySelectorAll('.section');
            sections.forEach(section => section.classList.remove('active'));
            document.getElementById(sectionId).classList.add('active');
        }

        // Default to showing the Club section on load
        window.onload = () => showSection('club');
    </script>

    <%
        // Prevent browser caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        // Validate session
        HttpSession Session = request.getSession(false);
        if (Session == null || Session.getAttribute("Student_ID") == null ||Session.getAttribute("Role_ID") == null || (int)Session.getAttribute("Role_ID") != 1) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Retrieve session attributes
        int studentId = (Integer) Session.getAttribute("Student_ID");
        String studentName = (String) Session.getAttribute("Name");

        // Database configuration
        String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
        String DB_USER = "u9946_Kmmw1Vvrcg";
        String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Query to check if the logged-in student is a president
            String query = "SELECT Club_ID FROM club WHERE President_ID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, studentId);
            rs = pst.executeQuery();

            if (!rs.next()) {
                // Redirect if the student is not a president
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
</body>
</html>