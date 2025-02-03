<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reset Password</title>
<link rel="stylesheet" href="form.css">
<link rel="icon" type="image/x-icon"
	href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
</head>
<body>
	<div class="wrapper">

		<div class="logo">
			<img
				src="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp"
				alt="uitm">
		</div>

		<div class="text-center mt-4 name">
			<h2 style="text-align: center">Reset Your Password</h2>
		</div>
		<%
            // Retrieve any message passed in the request, such as errors or confirmations
            String message = request.getParameter("message");
        %>
		<% if (message != null) { %>
		<div class="message"><%= message %></div>
		<% } %>

		<form action="UpdatePasswordServlet" method="post">
			<label for="lastEmail">Last Email Address:</label>
			<div class="form-field">
				<input type="email" id="lastEmail" name="lastEmail"
					placeholder="Enter your registered email" required>
			</div>

			<label for="student_id">Student ID:</label>
			<div class="form-field">
				<input type="text" id="student_id" name="student_id"
					placeholder="Enter your Student ID" required>
			</div>

			<label for="newPassword">New Password:</label>
			<div class="form-field">
				<input type="password" id="newPassword" name="newPassword"
					placeholder="Enter new password" required>
			</div>

			<label for="confirmPassword">Confirm Password:</label>
			<div class="form-field">
				<input type="password" id="confirmPassword" name="confirmPassword"
					placeholder="Confirm new password" required>
			</div>

			<button class="btn mt-3">UPDATE PASSWORD</button>

			<div class="text-center fs-6">
				<p style="text-align: center;">
					<a href="Login.jsp">Back to Login</a>
				</p>
			</div>

		</form>
	</div>
</body>
</html>
