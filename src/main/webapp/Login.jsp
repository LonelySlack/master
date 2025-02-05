<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="form.css">
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
</head>
<body>
    <div class="wrapper">
        <div class="logo">
            <img src="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp" alt="uitm">
        </div>
        <div class="text-center mt-4 name">
            <h1 style=text-align:center>LOG IN</h1>
        </div>
        
        <form action="LoginController" method="post">
            <label for="student_id">Student ID</label>
            <div class="form-field">
                <input type="text" name="Student_ID" placeholder="Enter Student ID" required>
            </div>
            <label for="password">Password</label>
            <div class="form-field">
                <input type="password" name="Password" placeholder="Enter Password" required>
            </div>
            <button type="submit" class="btn">LOG IN</button>
            <div class="text-center fs-6">
                <p style=text-align:center><a href="ResetPassword.jsp">Forget password?</a> or <a href="Signup.jsp">Sign up</a></p>
            </div>
        </form>
    </div>
</body>
</html>
