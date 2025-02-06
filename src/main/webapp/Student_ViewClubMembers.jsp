<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Members</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        h1 {
            color: #00f2fe;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #00f2fe;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .no-members {
            text-align: center;
            font-size: 18px;
            color: #ff5c5c;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Club Members</h1>

        <%
            // ✅ Get logged-in student ID
            String studentId = (String) session.getAttribute("Student_ID");
            if (studentId == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            boolean hasMembers = false;

            try {
                // ✅ Database connection
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC",
                    "u9946_Kmmw1Vvrcg",
                    "V6y2rsxfO0B636FUWqU^Ia=F"
                );

                // ✅ Query to fetch members & their clubs dynamically
                String query = "SELECT s.Name, s.Email, c.Club_Name FROM student s " +
                               "JOIN club_member cm ON s.Student_ID = cm.Student_ID " +
                               "JOIN club c ON cm.Club_ID = c.Club_ID " +
                               "WHERE cm.Club_ID IN (SELECT Club_ID FROM club_member WHERE Student_ID = ?) " +
                               "ORDER BY c.Club_Name, s.Name";

                pst = con.prepareStatement(query);
                pst.setString(1, studentId);
                rs = pst.executeQuery();
        %>

        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Club</th>
            </tr>

        <%
            while (rs.next()) {
                hasMembers = true;
        %>
            <tr>
                <td><%= rs.getString("Name") %></td>
                <td><%= rs.getString("Email") %></td>
                <td><%= rs.getString("Club_Name") %></td>
            </tr>
        <%
            }
            if (!hasMembers) {
        %>
            <tr>
                <td colspan="3" class="no-members">No members found in your club.</td>
            </tr>
        <%
            }
        %>
        </table>

        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            }
        %>

    </div>

</body>
</html>
