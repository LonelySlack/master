<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link rel="stylesheet" href="form.css">
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
%>

<script id="replace_with_navbar" src="nav.js"></script>

<div class="wrapper">
    <h2>Update Your Profile</h2>

    <%-- ✅ Display success or error messages --%>
    <% String message = request.getParameter("message");
       String error = request.getParameter("error");
       if (message != null) { %>
        <p class="message"><%= message %></p>
    <% } else if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>

    <%
        // ✅ Fetch user details from session
        String studentId = (String) session.getAttribute("Student_ID");
        String name = (String) session.getAttribute("Name");
        String email = (String) session.getAttribute("Email");
        String contactNumber = (String) session.getAttribute("Contact_Num");
        String faculty = (String) session.getAttribute("Faculty");
        String program = (String) session.getAttribute("Program");
    %>

    <form action="ProfileServlet" method="post">
        <input type="hidden" name="student_id" value="<%= studentId %>">

        <div class="form-field">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="<%= name != null ? name : "" %>" required>
        </div>

        <div class="form-field">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" required>
        </div>

        <div class="form-field">
            <label for="contactNumber">Contact Number</label>
            <input type="text" id="contactNumber" name="contactNumber" value="<%= contactNumber != null ? contactNumber : "" %>" required>
        </div>

        <div class="form-field">
            <label for="faculty">Faculty</label>
            <input type="text" id="faculty" name="faculty" value="<%= faculty != null ? faculty : "" %>" required>
        </div>

        <div class="form-field">
            <label for="program">Program</label>
            <input type="text" id="program" name="program" value="<%= program != null ? program : "" %>" required>
        </div>

        <button type="submit" class="btn" name="action" value="update">Save Changes</button>
    </form>
</div>

</body>
</html>
