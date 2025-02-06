<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="form.css">
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        /* Style for the show password button */
        .show-password {
            position: relative;
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
            <h1 style=text-align:center>LOG IN</h1>
        </div>
        
        <form action="LoginController" method="post">
            <label for="student_id">Student ID</label>
            <div class="form-field">
                <input type="text" name="Student_ID" placeholder="Enter Student ID" required>
            </div>
            <label for="password">Password</label>
            <div class="form-field show-password">
                <input type="password" id="password" name="Password" placeholder="Enter Password" required>
                <!-- Eye icon for toggling password visibility -->
                <button type="button" class="show-password-toggle" onclick="togglePasswordVisibility()">
                    <img id="eyeIcon" src="https://cdn-icons-png.flaticon.com/512/6803/6803345.png" alt="Show Password">
                </button>
            </div>
            <button type="submit" class="btn">LOG IN</button>
            <div class="text-center fs-6">
                <p style=text-align:center><a href="ResetPassword.jsp">Forget password?</a> or <a href="Signup.jsp">Sign up</a></p>
                 <p style=text-align:center><a href="LoginAdmin.jsp">Admin Login </a></p>
            </div>
        </form>
    </div>

    <script>
        // Function to toggle password visibility
        function togglePasswordVisibility() {
            const passwordField = document.getElementById("password");
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