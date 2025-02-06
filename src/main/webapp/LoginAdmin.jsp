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
<style>
    .form-field {
        position: relative;
        margin-bottom: 15px;
    }

    input[type="password"] {
        width: 100%;
        padding: 8px;
        padding-right: 30px; /* Space for the eye icon */
        box-sizing: border-box;
    }

    .show-password-toggle {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        cursor: pointer;
        width: 20px;
        height: 20px;
        padding: 0;
    }

    .show-password-toggle img {
        width: 100%;
        height: auto;
    }
</style>
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
                <input type="password" id="Admin_Password" name="Admin_Password" placeholder="Enter Password" required>
                <button type="button" class="show-password-toggle" onclick="togglePasswordVisibility()">
                    <img id="eyeIcon" src="https://cdn-icons-png.flaticon.com/512/6803/6803345.png" alt="Show Password">
                </button>
            </div>
            <button type="submit" class="btn">Login</button>
            <p style=text-align:center><a href="Login.jsp">Student Login </a></p>
        </form>
    </div>
    <script>
        // Function to toggle password visibility
        function togglePasswordVisibility() {
            const passwordField = document.getElementById("Admin_Password");
            const eyeIcon = document.getElementById("eyeIcon");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                eyeIcon.src = "https://cdn-icons-png.flaticon.com/512/6684/6684701.png"; // Hide icon
            } else {
                passwordField.type = "password";
                eyeIcon.src = "https://cdn-icons-png.flaticon.com/512/6803/6803345.png"; // Show icon
            }
        }
    </script>
</body>
</html>