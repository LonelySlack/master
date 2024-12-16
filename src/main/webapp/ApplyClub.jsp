<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Clubs</title>
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
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
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
        tr:hover {
            background-color: #f2f2f2;
        }
        form button {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
        form button:hover {
            background-color: #45a049;
        }
        .no-clubs {
            color: red;
            text-align: center;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h1>Available Clubs</h1>

    <%
        String studentId = (String) session.getAttribute("Student_ID");
        if (studentId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        boolean hasClubs = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

            // Fetch all clubs
            String query = "SELECT Club_ID, Club_Name, Club_Desc, Club_Est_Date FROM club";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
    %>

    <table>
        <tr>
            <th>Club ID</th>
            <th>Club Name</th>
            <th>Description</th>
            <th>Established Date</th>
            <th>Action</th>
        </tr>

        <%
            while (rs.next()) {
                hasClubs = true;
        %>
        <tr>
            <td><%= rs.getInt("Club_ID") %></td>
            <td><%= rs.getString("Club_Name") %></td>
            <td><%= rs.getString("Club_Desc") %></td>
            <td><%= rs.getDate("Club_Est_Date") %></td>
            <td>
                <form action="ApplyClubServlet" method="post">
                    <input type="hidden" name="Club_ID" value="<%= rs.getInt("Club_ID") %>">
                    <input type="hidden" name="Student_ID" value="<%= studentId %>">
                    <button type="submit">Apply</button>
                </form>
            </td>
        </tr>
        <%
            }
            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!hasClubs) {
        %>
        <tr>
            <td colspan="5" class="no-clubs">No clubs are currently available.</td>
        </tr>
        <%
        }
        %>
    </table>
</body>
</html>