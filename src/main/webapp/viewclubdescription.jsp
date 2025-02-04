<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon"
    href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <title>Club Description</title>
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
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .club-info {
            margin-bottom: 15px;
        }
        .club-info label {
            font-weight: bold;
            color: #4caf50;
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
    <script id="replace_with_navbar" src="nav.js"></script>
    <h1>Club Description</h1>
    <%
        String studentId = (String) session.getAttribute("Student_ID");
        if (studentId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String clubIdParam = request.getParameter("Club_ID");
        if (clubIdParam == null || clubIdParam.isEmpty()) {
            response.sendRedirect("ViewClubs.jsp");
            return;
        }
        int clubId = Integer.parseInt(clubIdParam);
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");
            String query = "SELECT Club_Name, Club_Desc, Club_Est_Date FROM club WHERE Club_ID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, clubId);
            rs = pst.executeQuery();
            if (rs.next()) {
    %>
    
    <%-- ✅ Prevent Caching --%>
<%
    // Set HTTP headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies

    // Validate Session
    if (session == null || session.getAttribute("Student_ID") == null) {
        response.sendRedirect("Login.jsp"); // Redirect if session is invalid
        return;
    }

    // Retrieve session attributes
    String studentName = (String) session.getAttribute("Name");

    // Ensure name is not null
    if (studentName == null) {
        studentName = "Guest";
    }
%>
    
    <div class="club-container">
        <div class="club-info">
            <label>Club Name:</label>
            <span><%= rs.getString("Club_Name") %></span>
        </div>
        <div class="club-info">
            <label>Description:</label>
            <span><%= rs.getString("Club_Desc") %></span>
        </div>
        <div class="club-info">
            <label>Established Date:</label>
            <span><%= rs.getDate("Club_Est_Date") %></span>
        </div>
    </div>
    <%
            } else {
                response.sendRedirect("ViewClubs.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
    %>
    <a href="viewclub.jsp" class="back-button">Back to Clubs</a>
</body>
</html>