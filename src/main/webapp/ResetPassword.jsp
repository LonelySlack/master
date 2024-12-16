<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
        }
        .container {
            margin: 50px auto;
            max-width: 500px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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
        .message {
            text-align: center;
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
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
    <div class="container">
        <h1>Reset Your Password</h1>

        <%
            // Retrieve any message passed in the request, such as errors or confirmations
            String message = request.getParameter("message");
        %>
        <% if (message != null) { %>
            <div class="message"><%= message %></div>
        <% } %>

        <form action="UpdatePasswordServlet" method="post">
            <label for="lastEmail">Last Email Address:</label>
            <input type="email" id="lastEmail" name="lastEmail" placeholder="Enter your registered email" required>

            <label for="icDigits">Last 4 Digits of IC Number:</label>
            <input type="text" id="icDigits" name="icDigits" placeholder="Enter last 4 digits of IC" maxlength="4" required>

            <label for="phoneNumber">Full Phone Number:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter your registered phone number" required>

            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required>

            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>

            <button type="submit">Update Password</button>
        </form>
    </div>
</body>
</html>
