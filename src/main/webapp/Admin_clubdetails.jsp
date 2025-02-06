<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Details</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        table th {
            background-color: #4caf50;
            color: white;
        }
        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table tr:hover {
            background-color: #f1f1f1;
        }
        form {
            margin-top: 20px;
        }
        select, button {
            padding: 8px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #4caf50;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <script id="replace_with_navbar" src="nav.js"></script>
    <h1>Club Details</h1>
    <%
        String adminId = (String) session.getAttribute("Admin_ID");
        if (adminId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String clubIdParam = request.getParameter("Club_ID");
        if (clubIdParam == null || clubIdParam.isEmpty()) {
            response.sendRedirect("Admin_home.jsp");
            return;
        }

        int clubId = Integer.parseInt(clubIdParam);

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            // Query to fetch club details
            String query = "SELECT * FROM club WHERE Club_ID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, clubId);
            rs = pst.executeQuery();

            if (rs.next()) {
                String clubName = rs.getString("Club_Name");
                String clubDesc = rs.getString("Club_Desc");
                String clubEmail = rs.getString("Club_Email");
                String clubCategory = rs.getString("Club_Category");
                String clubStatus = rs.getString("Club_Status");
    %>

    <div class="club-container">
        <div class="club-info">
            <label>Club Name:</label>
            <span><%= clubName %></span>
        </div>
        <div class="club-info">
            <label>Description:</label>
            <span><%= clubDesc %></span>
        </div>
        <div class="club-info">
            <label>Email:</label>
            <span><%= clubEmail %></span>
        </div>
        <div class="club-info">
            <label>Category:</label>
            <span><%= clubCategory %></span>
        </div>
        <form action="UpdateClubStatus" method="POST">
            <input type="hidden" name="Club_ID" value="<%= clubId %>">
            <label for="status">Set Club Status:</label>
            <select name="status" id="status">
                <option value="Active" <%= "Active".equals(clubStatus) ? "selected" : "" %>>Active</option>
                <option value="Inactive" <%= "Inactive".equals(clubStatus) ? "selected" : "" %>>Inactive</option>
            </select>
            <button type="submit">Update Status</button>
        </form>
    </div>

    <h2>Manage Club Members</h2>
    <div class="club-container">
        <table>
            <thead>
                <tr>
                    <th>Member Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Query to fetch club members
                    String memberQuery = "SELECT cm.Club_Member_ID, s.Name, s.Email, r.Role_Name, cm.Member_Status " +
                                         "FROM club_member cm " +
                                         "JOIN student s ON cm.Student_ID = s.Student_ID " +
                                         "JOIN role r ON cm.Role_ID = r.Role_ID " +
                                         "WHERE cm.Club_ID = ?";
                    pst = con.prepareStatement(memberQuery);
                    pst.setInt(1, clubId);
                    rs = pst.executeQuery();

                    while (rs.next()) {
                        int memberId = rs.getInt("Club_Member_ID");
                        String memberName = rs.getString("Name");
                        String memberEmail = rs.getString("Email");
                        String roleName = rs.getString("Role_Name");
                        String memberStatus = rs.getString("Member_Status");
                %>
                <tr>
                    <td><%= memberName %></td>
                    <td><%= memberEmail %></td>
                    <td>
                        <form action="UpdateMemberRole" method="POST" style="display:inline;">
                            <input type="hidden" name="Club_Member_ID" value="<%= memberId %>">
                            <select name="role" onchange="this.form.submit()">
                                <option value="1" <%= "President".equals(roleName) ? "selected" : "" %>>President</option>
                                <option value="2" <%= "Member".equals(roleName) ? "selected" : "" %>>Member</option>
                            </select>
                        </form>
                    </td>
                    <td>
                        <form action="UpdateMemberStatus" method="POST" style="display:inline;">
                            <input type="hidden" name="Club_Member_ID" value="<%= memberId %>">
                            <select name="status" onchange="this.form.submit()">
                                <option value="Active" <%= "Active".equals(memberStatus) ? "selected" : "" %>>Active</option>
                                <option value="Inactive" <%= "Inactive".equals(memberStatus) ? "selected" : "" %>>Inactive</option>
                                <option value="Pending" <%= "Pending".equals(memberStatus) ? "selected" : "" %>>Pending</option>
                            </select>
                        </form>
                    </td>
                    <td>
                        <form action="RemoveMember" method="POST" style="display:inline;">
                            <input type="hidden" name="Club_Member_ID" value="<%= memberId %>">
                            <button type="submit" style="background-color: #f44336;">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <%
            } else {
                response.sendRedirect("Admin_home.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
    %>
    <a href="Admin_home.jsp" class="back-button">Back to Dashboard</a>
</body>
</html>