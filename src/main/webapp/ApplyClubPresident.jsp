<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply to be Club President</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
        }
        .wrapper {
            max-width: 500px;
            margin: 50px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
        }
        .wrapper h1 {
            color: #00f2fe;
            margin-bottom: 20px;
        }
        .status {
            margin-bottom: 20px;
            padding: 10px;
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .status h3 {
            color: #00f2fe;
        }
        .form-field {
            margin-bottom: 15px;
            text-align: center;
        }
        .form-field label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        .form-field textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
            height: 100px;
            font-size: 14px;
        }
        .form-field button, .create-club-btn {
            width: 100%;
            padding: 10px;
            background: #00f2fe;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }
        .form-field button:hover, .create-club-btn:hover {
            background: #4facfe;
        }
        .form-field button:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        .create-club-btn {
            background-color: #4caf50;
        }
        .create-club-btn:hover {
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
<script id="replace_with_navbar" src="nav.js"></script>
    <div class="wrapper">
        <h1>Apply to be Club President</h1>

        <%-- Fetch the President Application Status from Database --%>
        <%
            String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
            String DB_USER = "u9946_Kmmw1Vvrcg";
            String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            String applicationStatus = "Not Applied";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Query to fetch President Application Status
                String query = "SELECT Approval_Status FROM president_application WHERE Student_ID = ?";
                pst = con.prepareStatement(query);
                pst.setInt(1, Integer.parseInt((String) session.getAttribute("Student_ID")));
                rs = pst.executeQuery();

                if (rs.next()) {
                    applicationStatus = rs.getString("Approval_Status");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { /* Ignored */ }
                try { if (pst != null) pst.close(); } catch (SQLException e) { /* Ignored */ }
                try { if (con != null) con.close(); } catch (SQLException e) { /* Ignored */ }
            }
        %>

        <%-- Display Application Status --%>
        <div class="status">
            <h3>Your Application Status: <%= applicationStatus %></h3>
            <p>
                <% if ("Approved".equals(applicationStatus)) { %>
                    ✅ Congratulations! Your application has been approved. You can now create a club.
                <% } else if ("Pending".equals(applicationStatus)) { %>
                    ⏳ Your application is under review.
                <% } else if ("Rejected".equals(applicationStatus)) { %>
                    ❌ Unfortunately, your application was rejected.
                <% } else { %>
                    ℹ️ You have not applied to be a club president yet.
                <% } %>
            </p>
        </div>

        <%-- Display Form for New Application if Not Already Applied --%>
        <% if ("Not Applied".equals(applicationStatus)) { %>
        <form action="ApplyClubPresident" method="post">
            <div class="form-field">
                <label for="reason">Why do you want to become a Club President?</label>
                <textarea name="reason" id="reason" placeholder="Explain your motivation..." required></textarea>
            </div>
            <div class="form-field">
                <button type="submit">Submit Application</button>
            </div>
        </form>
        <% } else if ("Approved".equals(applicationStatus)) { %>
        <div class="form-field">
            <a href="CreateClub.jsp" class="create-club-btn">Create Club</a>
        </div>
        <% } else { %>
        <div class="form-field">
            <button type="button" disabled>You have already applied.</button>
        </div>
        <% } %>
    </div>
    <div><a href="viewclub.jsp" class="back-button">Back to Clubs</a></div>
</body>
</html>
