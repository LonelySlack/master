<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Clubs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            text-align: center;
            color: white;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 36px;
        }
        .cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            flex: 1;
            max-width: 300px;
            min-width: 250px;
            text-align: center;
        }
        .card h2 {
            color: #00f2fe;
            margin-bottom: 10px;
        }
        .card p {
            color: #333;
        }
        .no-clubs {
            text-align: center;
            color: white;
            font-size: 18px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%
        String studentId = (String) session.getAttribute("Student_ID");
        if (studentId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            String query = "SELECT c.Club_Name, c.Club_Desc FROM club c " +
                           "JOIN club_member cm ON c.Club_ID = cm.Club_ID WHERE cm.Student_ID = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, studentId);
            rs = pst.executeQuery();

            boolean hasClubs = false;
    %>
    <div class="container">
        <div class="header">
            <h1>Your Clubs</h1>
        </div>
        <div class="cards">
            <%
                while (rs.next()) {
                    hasClubs = true;
            %>
            <div class="card">
                <h2><%= rs.getString("Club_Name") %></h2>
                <p><%= rs.getString("Club_Desc") %></p>
            </div>
            <%
                }

                if (!hasClubs) {
            %>
            <div class="no-clubs">
                <p>You are not currently a member of any club.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
    %>
</body>
</html>
