<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club member </title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            color: #333;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background: #00f2fe;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }

        .container {
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 1200px;
        }

        h1, h2 {
            text-align: center;
            color: #00f2fe;
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
            background: #00f2fe;
            color: white;
        }

        button, .accept-btn {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        button:hover, .accept-btn:hover {
            background-color: #45a049;
        }

        .delete-btn {
            background-color: #f44336;
        }

        .delete-btn:hover {
            background-color: #d32f2f;
        }

        .btn {
            text-decoration: none;
            color: white;
            background: #00f2fe;
            padding: 10px 20px;
            border-radius: 5px;
            display: inline-block;
            margin-top: 10px;
        }

        .btn:hover {
            background: #4facfe;
        }

        .center-text {
            text-align: center;
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
<script id="replace_with_presidentnavbar" src="presidentnavbar.js"></script>
    <div class="container">
        <h1>Welcome, <%= session.getAttribute("Name") %>!</h1>
        <p class="center-text">Here is the list of members and pending applications for your club.</p>

        <table>
            <tr>
                <th>Member ID</th>
                <th>Student ID</th>
                <th>Member Status</th>
                <th>Register Date</th>
                <th>Role ID</th>
                <th>Actions</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Integer clubId = (Integer) session.getAttribute("Club_ID");
                    if (clubId == null) {
            %>
                <tr>
                    <td colspan="6" class="center-text">Error: Club_ID is missing. Please contact support.</td>
                </tr>
            <%
                        return;
                    }

                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

                    String query = "SELECT * FROM club_member WHERE Club_ID = ?";
                    pst = con.prepareStatement(query);
                    pst.setInt(1, clubId);
                    rs = pst.executeQuery();

                    boolean hasResults = false;

                    while (rs.next()) {
                        hasResults = true;
                        String memberStatus = rs.getString("Member_Status");
            %>
            <tr>
                <td><%= rs.getInt("Club_Member_ID") %></td>
                <td><%= rs.getString("Student_ID") %></td>
                <td><%= memberStatus %></td>
                <td><%= rs.getDate("Register_Date") %></td>
                <td><%= rs.getString("Role_ID") %></td>
                <td>
                    <% if ("Pending".equalsIgnoreCase(memberStatus)) { %>
                        <form action="ApproveMemberServlet" method="post" style="display:inline;">
                            <input type="hidden" name="Member_ID" value="<%= rs.getInt("Club_Member_ID") %>">
                            <button type="submit" class="accept-btn">Accept</button>
                        </form>
                    <% } %>
                    <form action="UpdateMemberServlet" method="post" style="display:inline;">
                        <input type="hidden" name="Member_ID" value="<%= rs.getInt("Club_Member_ID") %>">
                        <button type="submit">Update</button>
                    </form>
                    <form action="DeleteMemberServlet" method="post" style="display:inline;">
                        <input type="hidden" name="Member_ID" value="<%= rs.getInt("Club_Member_ID") %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }

                    if (!hasResults) {
            %>
                <tr>
                    <td colspan="6" class="center-text">No members or pending applications found for your club.</td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="6" class="center-text">Error loading club members. Please try again later.</td>
            </tr>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                }
            %>
        </table>

       
    </div>
    <div><a href="President_home.jsp" class="back-button">Back to Home</a></div>
</body>
</html>
