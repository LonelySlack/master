<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Approve Applications</title>
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
        <%-- Display success or error message if redirected from UpdateApprovalServlet --%>
    <% 
        String message = request.getParameter("message");
        String status = request.getParameter("status");
        if (message != null && !message.isEmpty()) {
    %>
        <div class="status-message <%= "success".equals(status) ? "success" : "error" %>">
            <%= message %>
        </div>
    <% } %>

    <table>
        <tr>
            <th>Application ID</th>
            <th>Application Date</th>
            <th>Approval Status</th>
            <th>Student ID</th>
            <th>Reason</th>
            <th>Admin ID</th>
            <th>Actions</th>
            <th>View Details</th>
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

                // Query to fetch all applications
                String query = "SELECT Application_ID, Application_Date, Approval_Status, Student_ID, Reason, Admin_ID FROM president_application";
                PreparedStatement pst = con.prepareStatement(query);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    hasData = true; // Flag to indicate data exists
        %>
        <tr>
            <td><%= rs.getInt("Application_ID") %></td>
            <td><%= rs.getDate("Application_Date") %></td>
            <td><strong style="<%= "Approved".equals(rs.getString("Approval_Status")) ? "color: green;" : "color: red;" %>">
                <%= rs.getString("Approval_Status") %></strong>
            </td>
            <td><%= rs.getString("Student_ID") %></td>
            <td><%= rs.getString("Reason") != null ? rs.getString("Reason") : "No reason provided" %></td>
            <td><%= rs.getString("Admin_ID") != null ? rs.getString("Admin_ID") : "Not assigned" %></td>
            <td>
                <!-- Approve Button -->
                <form action="UpdateApprovalServlet" method="post" style="display: inline-block;">
                    <input type="hidden" name="Application_ID" value="<%= rs.getInt("Application_ID") %>">
                    <input type="hidden" name="Approval_Status" value="Approved">
                    <button type="submit">Approve</button>
                </form>

                <!-- Reject Button -->
                <form action="UpdateApprovalServlet" method="post" style="display: inline-block;">
                    <input type="hidden" name="Application_ID" value="<%= rs.getInt("Application_ID") %>">
                    <input type="hidden" name="Approval_Status" value="Rejected">
                    <button type="submit" class="reject-btn">Reject</button>
                </form>
            </td>
            <td>
                <!-- View details button that links to the student and club details page -->
                <form action="studentClubDetails.jsp" method="get">
                    <input type="hidden" name="studentId" value="<%= rs.getString("Student_ID") %>">
                    <button type="submit" class="view-details-btn">View Details</button>
                </form>
            </td>
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
            <td colspan="8" class="no-data">No applications found.</td>
        </tr>
        <%
            }
        %>
    </table>
    <a href="Admin_home.jsp" class="back-button">Back to Dashboard</a>
</body>
</html>
