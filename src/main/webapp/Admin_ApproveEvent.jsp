<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Approve Events</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
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
            width: 90%;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #00f2fe;
            color: white;
        }
        .approve-btn {
            background-color: #4caf50;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .approve-btn:hover {
            background-color: #45a049;
        }
        .reject-btn {
            background-color: #f44336;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .reject-btn:hover {
            background-color: #d32f2f;
        }
        .no-events {
            text-align: center;
            color: red;
            font-size: 18px;
            margin-top: 20px;
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
    <h1>Approve Events</h1>
    <div class="event-container">
        <table>
            <tr>
                <th>Event ID</th>
                <th>Event Name</th>
                <th>Event Date</th>
                <th>Description</th>
                <th>Location</th>
                <th>Club Name</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <%
                // ✅ Secure session handling
                String adminId = (String) session.getAttribute("Admin_ID");
                if (adminId == null) {
                    response.sendRedirect("AdminLogin.jsp");
                    return;
                }
                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;
                try {
                    // ✅ Use latest MySQL JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection(
                        "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC",
                        "u9946_Kmmw1Vvrcg",
                        "V6y2rsxfO0B636FUWqU^Ia=F"
                    );
                    // ✅ Fetch all pending events with club names
                    String query = "SELECT e.Event_ID, e.Event_Name, e.Event_Date, e.Event_Desc, e.Event_Location, c.Club_Name, e.Event_Status " +
                                   "FROM event e " +
                                   "JOIN club c ON e.Club_ID = c.Club_ID " +
                                   "WHERE e.Event_Status = 'Pending'";
                    pst = con.prepareStatement(query);
                    rs = pst.executeQuery();
                    boolean hasEvents = false;
                    while (rs.next()) {
                        hasEvents = true;
            %>
            <tr>
                <td><%= rs.getInt("Event_ID") %></td>
                <td><%= rs.getString("Event_Name") %></td>
                <td><%= rs.getDate("Event_Date") %></td>
                <td><%= rs.getString("Event_Desc") %></td>
                <td><%= rs.getString("Event_Location") %></td>
                <td><%= rs.getString("Club_Name") %></td>
                <td><%= rs.getString("Event_Status") %></td>
                <td>
                    <!-- ✅ Approve Event -->
                    <form action="Admin_UpdateEventServlet" method="post" style="display:inline;">
                        <input type="hidden" name="Event_ID" value="<%= rs.getInt("Event_ID") %>">
                        <input type="hidden" name="Approval_Status" value="Approved">
                        <button type="submit" class="approve-btn">Approve</button>
                    </form>
                    <!-- ❌ Reject Event -->
                    <form action="Admin_UpdateEventServlet" method="post" style="display:inline;">
                        <input type="hidden" name="Event_ID" value="<%= rs.getInt("Event_ID") %>">
                        <input type="hidden" name="Approval_Status" value="Rejected">
                        <button type="submit" class="reject-btn">Reject</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    // ✅ No pending events
                    if (!hasEvents) {
            %>
            <tr>
                <td colspan="8" class="no-events">No events pending approval.</td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="8" class="no-events">Error loading events. Please try again.</td>
            </tr>
            <%
                } finally {
                    // ✅ Properly close resources
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                }
            %>
        </table>
        <a href="Admin_home.jsp" class="back-button">Back to Dashboard</a>
    </div>
</body>
</html>