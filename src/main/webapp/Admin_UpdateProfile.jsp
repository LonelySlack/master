<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Admin Profile</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
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
        .wrapper h2 {
            color: #00f2fe;
            margin-bottom: 20px;
        }
        .form-field {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-field label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .form-field input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #00f2fe;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background: #4facfe;
        }
        .message {
            color: green;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<%-- ✅ Prevent Caching --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    // Validate session
    if (session == null || session.getAttribute("Admin_ID") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Fetch admin details from session
    String adminId = (String) session.getAttribute("Admin_ID");
    String adminName = (String) session.getAttribute("Admin_Name");
    String adminContactNumber = (String) session.getAttribute("Admin_Contact_Num");
%>
<script id="replace_with_navbar" src="nav.js"></script>
<div class="wrapper">
    <h2>Update Your Profile</h2>
    <%-- ✅ Display success or error messages --%>
    <% 
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) { 
    %>
        <p class="message"><%= message %></p>
    <% } else if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>
    <form action="AdminProfileServlet" method="post">
        <input type="hidden" name="admin_id" value="<%= adminId %>">
        <div class="form-field">
            <label for="admin_name">Name</label>
            <input type="text" id="admin_name" name="admin_name" value="<%= adminName != null ? adminName : "" %>" required>
        </div>
        <div class="form-field">
            <label for="contact_number">Contact Number</label>
            <input type="text" id="contact_number" name="contact_number" value="<%= adminContactNumber != null ? adminContactNumber : "" %>" required>
        </div>
        <div class="form-field">
            <label for="password">New Password</label>
            <input type="password" id="password" name="password" placeholder="Enter new password (optional)">
        </div>
        <button type="submit" class="btn" name="action" value="update">Save Changes</button>
    </form>
</div>
</body>
</html>