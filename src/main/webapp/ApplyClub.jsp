<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Clubs</title>
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
        .applied-message {
            color: green;
            text-align: center;
            font-size: 16px;
        }
        .error-message {
            color: red;
            text-align: center;
            font-size: 16px;
        }
        .success-message {
            color: green;
            text-align: center;
            font-size: 16px;
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
    <h1>Available Clubs</h1>

    <!-- Display success or error messages -->
    <%
        String successMessage = request.getParameter("success");
        String errorMessage = request.getParameter("error");

        if (successMessage != null) {
    %>
    <div class="success-message"><%= successMessage %></div>
    <%
        }

        if (errorMessage != null) {
    %>
    <div class="error-message"><%= errorMessage %></div>
    <%
        }
    %>

    <%
        String studentId = (String) session.getAttribute("Student_ID");
        if (studentId == null) {
            response.sendRedirect("Login.jsp"); // Redirect to login if not logged in
            return;
        }

        boolean hasClubs = false;
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");

            // Fetch all clubs
            String query = "SELECT Club_ID, Club_Name, Club_Desc, Club_Est_Date FROM club";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();
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
                int clubId = rs.getInt("Club_ID");
                String clubName = rs.getString("Club_Name");
                String clubDesc = rs.getString("Club_Desc");
                java.sql.Date clubEstDate = rs.getDate("Club_Est_Date");

                // Check if the student has already applied to this club
                String checkQuery = "SELECT COUNT(*) AS Application_Count FROM club_member WHERE Student_ID = ? AND Club_ID = ?";
                PreparedStatement checkPst = con.prepareStatement(checkQuery);
                checkPst.setString(1, studentId);
                checkPst.setInt(2, clubId);
                ResultSet checkRs = checkPst.executeQuery();

                boolean alreadyApplied = false;
                if (checkRs.next() && checkRs.getInt("Application_Count") > 0) {
                    alreadyApplied = true;
                }
                checkRs.close();
                checkPst.close();
        %>
        <tr>
            <td><%= clubId %></td>
            <td><%= clubName %></td>
            <td><%= clubDesc.length() > 50 ? clubDesc.substring(0, 50) + "..." : clubDesc %></td>
            <td><%= clubEstDate %></td>
            <td>
                <%
                    if (alreadyApplied) {
                %>
                <span class="applied-message">Already Applied</span>
                <%
                    } else {
                %>
                <form action="ApplyClubServlet" method="post">
                    <input type="hidden" name="Club_ID" value="<%= clubId %>">
                    <input type="hidden" name="Student_ID" value="<%= studentId %>">
                    <button type="submit">Apply</button>
                </form>
                <%
                    }
                %>
            </td>
        </tr>
        <%
            }
            rs.close();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
    <a href="welcome.jsp" class="back-button">Back to Home</a>
</body>
</html>