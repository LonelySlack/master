<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #fff;
        }
        .status-message {
            text-align: center;
            font-size: 16px;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #00f2fe;
            color: white;
        }
        select, button {
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        button {
            background-color: #4caf50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .no-data {
            color: red;
            font-size: 16px;
            text-align: center;
            padding: 20px;
        }
        .view-details-btn {
            background-color: #00f2fe;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .view-details-btn:hover {
            background-color: #4facfe;
        }
        .reject-btn {
            background-color: #f44336;
        }
        .reject-btn:hover {
            background-color: #e53935;
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
    </style>
</head>
<body>
<script id="replace_with_adminnavbar" src="adminnavbar.js"></script>
<%-- Display success or error message if redirected from UpdateEventServlet --%>
<%
    String message = request.getParameter("message");
    String status = request.getParameter("status");
    if (message != null && !message.isEmpty()) {
%>
    <div class="status-message <%= "success".equals(status) ? "success" : "error" %>">
        <%= message %>
    </div>
<% } %>

<h1>Event Details</h1>
<table>
    <tr>
        <th>Event ID</th>
        <th>Event Name</th>
        <th>Event Date</th>
        <th>Description</th>
        <th>Location</th>
        <th>Status</th>
        <th>Club Name</th>
       
    </tr>
    <%
        boolean hasData = false; // To check if data exists
        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            // Database connection (Use correct DB credentials)
            String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
            String DB_USER = "u9946_Kmmw1Vvrcg";
            String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            // Query to fetch all events with club details
            String query = "SELECT e.Event_ID, e.Event_Name, e.Event_Date, e.Event_Desc, e.Event_Location, e.Event_Status, c.Club_Name " +
                           "FROM event e " +
                           "JOIN club c ON e.Club_ID = c.Club_ID";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                hasData = true; // Flag to indicate data exists
    %>
    <tr>
        <td><%= rs.getInt("Event_ID") %></td>
        <td><%= rs.getString("Event_Name") %></td>
        <td><%= rs.getDate("Event_Date") %></td>
        <td><%= rs.getString("Event_Desc").length() > 50 ? rs.getString("Event_Desc").substring(0, 50) + "..." : rs.getString("Event_Desc") %></td>
        <td><%= rs.getString("Event_Location") %></td>
        <td><strong style="<%= "Completed".equals(rs.getString("Event_Status")) ? "color: green;" : "color: red;" %>">
            <%= rs.getString("Event_Status") %></strong>
        </td>
        <td><%= rs.getString("Club_Name") %></td>
         </tr>
    <%
            }
            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
    %>
    <tr>
        <td colspan="8" class="no-data">Error: <%= e.getMessage() %></td>
    </tr>
    <%
            e.printStackTrace();
        }
        if (!hasData) {
    %>
    <tr>
        <td colspan="8" class="no-data">No events found.</td>
    </tr>
    <%
        }
    %>
</table>
<a href="Admin_home.jsp" class="back-button">Back to Dashboard</a>
</body>
</html>