<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Details</title>
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
        .back-btn {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #4facfe;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-btn:hover {
            background-color: #00f2fe;
        }
    </style>
</head>
<body>
<script id="replace_with_navbar" src="nav.js"></script>
    <h1>Club Details</h1>
    <%
        int clubId = Integer.parseInt(request.getParameter("clubId"));
        boolean hasData = false; // To check if data exists
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");
            String query = "SELECT * FROM club WHERE Club_ID = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, clubId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                hasData = true; // Flag to indicate data exists
    %>
    <table>
        <tr>
            <th>Attribute</th>
            <th>Value</th>
        </tr>
        <tr>
            <td><strong>Club Name</strong></td>
            <td><%= rs.getString("Club_Name") %></td>
        </tr>
        <tr>
            <td><strong>Description</strong></td>
            <td><%= rs.getString("Club_Desc") %></td>
        </tr>
        <tr>
            <td><strong>Email</strong></td>
            <td><%= rs.getString("Club_Email") %></td>
        </tr>
        <tr>
            <td><strong>Category</strong></td>
            <td><%= rs.getString("Club_Category") %></td>
        </tr>
        <tr>
            <td><strong>Status</strong></td>
            <td><%= rs.getString("Club_Status") %></td>
        </tr>
    </table>
    <%
            }
            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
    %>
    <div class="no-data">Error: <%= e.getMessage() %></div>
    <%
            e.printStackTrace();
        }
        if (!hasData) {
    %>
    <div class="no-data">No details found for the selected club.</div>
    <%
        }
    %>
    <a href="welcomeAdmin.jsp" class="back-btn">Back to Dashboard</a>
</body>
</html>