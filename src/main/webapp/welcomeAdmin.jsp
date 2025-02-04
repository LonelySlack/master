<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Manage Clubs</title>
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
    </style>
</head>
<body>
<script id="replace_with_navbar" src="nav.js"></script>
    <h1>Welcome,Admin!</h1>
    <table>
        <tr>
            <th>Club ID</th>
            <th>Club Name</th>
            <th>Description</th>
            <th>Email</th>
            <th>Category</th>
            <th>Status</th>
            <th>Update Status</th>
            <th>View Details</th>
        </tr>
        <%
            boolean hasData = false; // To check if data exists
            try {
                // Load JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                // Database connection
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");
                // Query to fetch all clubs
                String query = "SELECT * FROM club";
                PreparedStatement pst = con.prepareStatement(query);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    hasData = true; // Flag to indicate data exists
        %>
        <tr>
            <td><%= rs.getInt("Club_ID") %></td>
            <td><%= rs.getString("Club_Name") %></td>
            <td><%= rs.getString("Club_Desc") %></td>
            <td><%= rs.getString("Club_Email") %></td>
            <td><%= rs.getString("Club_Category") %></td>
            <td><%= rs.getString("Club_Status") %></td>
            <td>
                <form action="UpdateClubStatusServlet" method="post">
                    <input type="hidden" name="Club_ID" value="<%= rs.getInt("Club_ID") %>">
                    <select name="Club_Status" required>
                        <option value="" disabled selected>Change Status</option>
                        <option value="Active" <%= "Active".equals(rs.getString("Club_Status")) ? "selected" : "" %>>Active</option>
                        <option value="Inactive" <%= "Inactive".equals(rs.getString("Club_Status")) ? "selected" : "" %>>Inactive</option>
                        <option value="Suspended" <%= "Suspended".equals(rs.getString("Club_Status")) ? "selected" : "" %>>Suspended</option>
                    </select>
                    <button type="submit">Update</button>
                </form>
            </td>
            <td>
                <!-- View details button that links to the club details page -->
                <form action="Admin_clubdetails.jsp" method="get">
                    <input type="hidden" name="clubId" value="<%= rs.getInt("Club_ID") %>">
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
            <td colspan="8" class="no-data">No clubs found.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>