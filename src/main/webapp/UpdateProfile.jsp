<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link rel="stylesheet" href="form.css">
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
</head>
<body>
    <script id="replace_with_navbar" src="nav.js"></script>
	<div class="wrapper">
	<div class="text-center mt-4 name">
        <h2 style=text-align:center>Update Your Profile</h2>
    </div>

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
            <div class="form-field">
            <input type="text" id="name" name="name" placeholder="Enter Name" value="<%= name != null ? name : "" %>" required>
            </div>

            <label for="email">Email</label>
            <div class="form-field">
            <input type="email" id="email" name="email" placeholder="Enter Email" value="<%= email != null ? email : "" %>" required>
            </div>

            <label for="contactNumber">Contact Number</label>
            <div class="form-field">
            <input type="text" id="contactNumber" name="contactNumber"  placeholder="Enter Contact Number" value="<%= contactNumber != null ? contactNumber : "" %>" required>
            </div>

            <label for="faculty">Faculty</label>
            <div class="form-field">
            <input type="text" id="faculty" name="faculty" placeholder="Enter Faculty" value="<%= faculty != null ? faculty : "" %>" required>
            </div>

            <label for="program">Program</label>
            <div class="form-field">
            <input type="text" id="program" name="program" placeholder="Enter Program" value="<%= program != null ? program : "" %>" required>
            </div>

            <button type="submit" name="action" class="btn" value="update">Save Changes</button>
        </form>
    </div>
</body>
</html>
