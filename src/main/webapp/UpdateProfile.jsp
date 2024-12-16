<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link rel="stylesheet" href="profile.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #00f2fe;
            padding: 15px 30px;
            color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .navbar .logo span {
            font-size: 24px;
            font-weight: bold;
        }
        .navbar .logout {
            background: white;
            color: #00f2fe;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .navbar .logout:hover {
            background: #d4f5fe;
        }
        .container {
            margin: 50px auto;
            max-width: 600px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        h1 {
            text-align: center;
            color: #00f2fe;
        }
        form label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }
        form input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        form input:focus {
            border-color: #00f2fe;
            outline: none;
        }
        button {
            display: block;
            width: 100%;
            background: #00f2fe;
            color: white;
            padding: 10px;
            margin-top: 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        button:hover {
            background: #4facfe;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">
            <span>Club Management</span>
        </div>
        <form action="LogoutServlet" method="post">
            <button type="submit" class="logout">Logout</button>
        </form>
    </div>

    <div class="container">
        <h1>Update Your Profile</h1>

        <%
            // Fetch user details from session
            String studentId = (String) session.getAttribute("Student_ID");
            String name = (String) session.getAttribute("Student_Name");
            String email = (String) session.getAttribute("Email");
            String contactNumber = (String) session.getAttribute("Contact_Num");
            String faculty = (String) session.getAttribute("Faculty");
            String program = (String) session.getAttribute("Program");
        %>

        <form action="ProfileServlet" method="post">
            <input type="hidden" name="student_id" value="<%= studentId %>">

            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="<%= name != null ? name : "" %>" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" required>

            <label for="contactNumber">Contact Number</label>
            <input type="text" id="contactNumber" name="contactNumber" value="<%= contactNumber != null ? contactNumber : "" %>" required>

            <label for="faculty">Faculty</label>
            <input type="text" id="faculty" name="faculty" value="<%= faculty != null ? faculty : "" %>" required>

            <label for="program">Program</label>
            <input type="text" id="program" name="program" value="<%= program != null ? program : "" %>" required>

            <button type="submit" name="action" value="update">Save Changes</button>
        </form>
    </div>
</body>
</html>
