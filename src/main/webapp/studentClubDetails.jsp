<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student and Club Details</title>
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
        .container {
            background: white;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            margin: 20px auto;
            max-width: 800px;
        }
        .container p {
            font-size: 16px;
            color: #333;
        }
        .btn {
            background-color: #4caf50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<script id="replace_with_navbar" src="nav.js"></script>

<%
    String studentId = request.getParameter("Student_ID");
    String studentName = "";
    String clubName = "";
    String clubId = "";
    int totalMembers = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

        // Query to get student details and their club information
        String query = "SELECT s.Name AS Student_Name, c.Club_Name, c.Club_ID, " +
                       "(SELECT COUNT(*) FROM club_member cm WHERE cm.Club_ID = c.Club_ID) AS Total_Members " +
                       "FROM student s " +
                       "JOIN club_member cm ON s.Student_ID = cm.Student_ID " +
                       "JOIN club c ON cm.Club_ID = c.Club_ID " +
                       "WHERE s.Student_ID = ?";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, studentId);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            studentName = rs.getString("Student_Name");
            clubName = rs.getString("Club_Name");
            clubId = rs.getString("Club_ID");
            totalMembers = rs.getInt("Total_Members");
        }

        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="container">
    <h1>Student and Club Details</h1>
    <p><strong>Student ID:</strong> <%= studentId %></p>
    <p><strong>Student Name:</strong> <%= studentName %></p>
    <p><strong>Club ID:</strong> <%= clubId %></p>
    <p><strong>Club Name:</strong> <%= clubName %></p>
    <p><strong>Total Members in Club:</strong> <%= totalMembers %></p>
    <form action="welcomeAdmin.jsp" method="get">
        <button type="submit" class="btn">Back to Dashboard</button>
    </form>
</div>

</body>
</html>
