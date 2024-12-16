<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Approve Applications</title>
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
    <h1>Welcome, Admin!</h1>

    <table>
        <tr>
            <th>Application ID</th>
            <th>Application Date</th>
            <th>Approval Status</th>
            <th>Student ID</th>
            <th>Admin ID</th>
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

                // Query to fetch all applications
                String query = "SELECT * FROM president_application";
                PreparedStatement pst = con.prepareStatement(query);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    hasData = true; // Flag to indicate data exists
        %>
        <tr>
            <td><%= rs.getInt("Application_ID") %></td>
            <td><%= rs.getDate("Application_Date") %></td>
            <td><%= rs.getString("Approval_Status") %></td>
            <td><%= rs.getString("Student_ID") %></td>
            <td><%= rs.getString("Admin_ID") %></td>
            <td>
                <form action="UpdateApprovalServlet" method="post">
                    <input type="hidden" name="Application_ID" value="<%= rs.getInt("Application_ID") %>">
                    <select name="Approval_Status" required>
                        <option value="" disabled selected>Change Status</option>
                        <option value="Approved" <%= "Approved".equals(rs.getString("Approval_Status")) ? "selected" : "" %>>Approved</option>
                        <option value="Pending" <%= "Pending".equals(rs.getString("Approval_Status")) ? "selected" : "" %>>Pending</option>
                        <option value="Rejected" <%= "Rejected".equals(rs.getString("Approval_Status")) ? "selected" : "" %>>Rejected</option>
                    </select>
                    <button type="submit">Update</button>
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
            <td colspan="7" class="no-data">Error: <%= e.getMessage() %></td>
        </tr>
        <%
                e.printStackTrace();
            }

            if (!hasData) {
        %>
        <tr>
            <td colspan="7" class="no-data">No applications found.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
