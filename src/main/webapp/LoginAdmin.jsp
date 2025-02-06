<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login</title>
<link rel="stylesheet" href="form.css">
	<link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
</head>
<body>
    <div class="wrapper">
    <div class="logo">
            <img src="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp" alt="uitm">
        </div>
       <div class="text-center mt-4 name">
            <h1>Admin Login</h1>
        </div>
        
        
        <!-- Display error message dynamically -->
        <div class="error-message">
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) { 
            %>
                <%= errorMessage %>
            <% } %>
        </div>

        <form action="AdminLoginServlet" method="post">
        <label for="Admin_ID">Admin ID</label>
            <div class="form-field">
                <input type="text" name="Admin_ID" placeholder="Enter Admin ID" required>
            </div>
            <label for="Admin_Password">Password</label>
            <div class="form-field">
                <input type="password" name="Admin_Password" placeholder="Enter Password" required>
            </div>
            <button type="submit" class="btn">Login</button>
                   <p style=text-align:center><a href="Login.jsp">Student Login </a></p>
        </form>
    </div>
</body>
</html>
