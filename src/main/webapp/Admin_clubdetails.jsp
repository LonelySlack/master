<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Clubs</title>
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
        .club-container {
            width: 90%;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #4caf50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .status-active {
            color: green;
            font-weight: bold;
        }
        .status-inactive {
            color: red;
            font-weight: bold;
        }
        .view-button {
            background-color: #4caf50;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .view-button:hover {
            background-color: #45a049;
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
    <h1>All Clubs</h1>

    <div class="club-container">
        <table>
            <thead>
                <tr>
                    <th>Club Name</th>
                    <th>Category</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

                        String query = "SELECT Club_ID, Club_Name, Club_Category, Club_Email, Club_Status FROM club";
                        pst = con.prepareStatement(query);
                        rs = pst.executeQuery();

                        while (rs.next()) {
                            int clubId = rs.getInt("Club_ID");
                            String clubName = rs.getString("Club_Name");
                            String clubCategory = rs.getString("Club_Category");
                            String clubEmail = rs.getString("Club_Email");
                            String clubStatus = rs.getString("Club_Status");
                %>
                <tr>
                    <td><%= clubName %></td>
                    <td><%= clubCategory %></td>
                    <td><%= clubEmail %></td>
                    <td class="<%= "Active".equals(clubStatus) ? "status-active" : "status-inactive" %>">
                        <%= clubStatus %>
                    </td>
                    <td>
                        <a href="Admin_viewclubdetails.jsp?Club_ID=<%= clubId %>" class="view-button">View Details</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException ignored) { }
                        try { if (pst != null) pst.close(); } catch (SQLException ignored) { }
                        try { if (con != null) con.close(); } catch (SQLException ignored) { }
                    }
                %>
            </tbody>
        </table>
    </div>
    <div><a href="Admin_home.jsp" class="back-button">Back to Dashboard</a></div>
</body>
</html>
