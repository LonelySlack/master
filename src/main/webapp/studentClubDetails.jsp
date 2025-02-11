<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #00f2fe;
        }
        .info {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            background: #f9f9f9;
        }
        .info strong {
            color: #00f2fe;
        }
        .back-btn {
            display: block;
            width: 100%;
            text-align: center;
            padding: 10px;
            background-color: #4facfe;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            transition: background 0.3s ease;
        }
        .back-btn:hover {
            background-color: #00f2fe;
        }
    </style>
</head>
<body>
<script id="replace_with_adminnavbar" src="adminnavbar.js"></script>
    <div class="container">
        <h1>Student Details</h1>

        <%
            // Get student ID from request
            String studentId = request.getParameter("studentId");
            if (studentId == null || studentId.trim().isEmpty()) {
                out.println("<p class='info'>Invalid Student ID.</p>");
            } else {
                try {
                    // Load JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    // Database connection (Use correct DB credentials)
                    String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
                    String DB_USER = "u9946_Kmmw1Vvrcg";
                    String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

                    Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Query to fetch student details
                    String query = "SELECT * FROM student WHERE Student_ID = ?";
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, studentId);
                    ResultSet rs = pst.executeQuery();

                    if (rs.next()) {
        %>
                        <div class="info"><strong>Student ID:</strong> <%= rs.getString("Student_ID") %></div>
                        <div class="info"><strong>Name:</strong> <%= rs.getString("Name") %></div>
                        <div class="info"><strong>Email:</strong> <%= rs.getString("Email") %></div>
                        <div class="info"><strong>Phone:</strong> <%= rs.getString("Contact_Num") %></div>
                        <div class="info"><strong>Faculty:</strong> <%= rs.getString("Faculty") %></div>
                        <div class="info"><strong>Program:</strong> <%= rs.getString("Program") %></div>
        <%
                    } else {
                        out.println("<p class='info'>Student details not found.</p>");
                    }

                    // Close resources
                    rs.close();
                    pst.close();
                    con.close();

                } catch (Exception e) {
                    out.println("<p class='info'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            }
        %>

        <a href="Admin_Applicationpresident.jsp" class="back-btn">Back to Dashboard</a>
    </div>
</body>
</html>
