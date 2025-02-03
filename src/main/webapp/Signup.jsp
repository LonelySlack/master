<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link rel="stylesheet" href="form.css">
<link rel="icon" type="image/x-icon"
	href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
<script>
    // Client-side validation for email format
    function validateForm() {
        const email = document.getElementById("email").value;
        const regex = /^[a-zA-Z0-9._-]+@student\.uitm\.edu\.my$/; // Example: Validating UiTM email format
        if (!regex.test(email)) {
            alert("Please enter a valid UiTM student email.");
            return false;
        }
        return true;
    }
</script>
</head>
<body>
	<div class="wrapper">
    <div class="logo">
            <img src="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp" alt="uitm">
        </div>
       <div class="text-center mt-4 name">
            <h1 style=text-align:center>SIGN UP</h1>
        </div>
		<form class="p-3 mt-3" action="SignupServlet" method="post"
			onsubmit="return validateForm()">
			<div class="form-container">

			<label for="student_id">Student ID</label>
			<div class="form-field d-flex align-items-center">
				<input type="text" name="student_id" id="student_id"
					placeholder="Enter Student ID" required>
			</div>
			<label for="name">Full Name</label>
			<div class="form-field d-flex align-items-center">
				<input type="text" name="name" id="name"
					placeholder="Enter Full Name" required>
			</div>
			
			<label for="email">Email</label>
			<div class="form-field d-flex align-items-center">
				<input type="email" name="email" id="email"
					placeholder="Enter UiTM Student Email" required>
			</div>
			<label for="cont_num">Contact Number</label>
			<div class="form-field d-flex align-items-center">
				<input type="text" name="cont_num" id="cont_num"
					placeholder="Enter Contact Number" required>
			</div>
			<label for="faculty">Faculty</label>
			<div class="form-field d-flex align-items-center">
				<input type="text" name="faculty" id="faculty" placeholder="Enter Faculty"
					required>
			</div>
			<label for="program">Program</label>
			<div class="form-field d-flex align-items-center">
				<input type="text" name="program" id="program" placeholder="Enter Program"
					required>
			</div>
			<label for="year">Year of Study</label>
			<div class="form-field d-flex align-items-center">
				<input type="text" name="year" id="year" placeholder="Enter Year of Study"
					required>
			</div>
			<label for="pwd">Password</label>
			<div class="form-field d-flex align-items-center">
				<input type="password" name="password" id="pwd"
					placeholder="Enter Password" minlength="8" required>
			</div>
			</div>
			<button type="submit" class="btn mt-3">SIGN UP</button>
		</form>
		<div class="text-center fs-6">
			<p style="text-align: center;">
				<a href="Login.jsp">Already have an account?</a>
			</p>
		</div>
	</div>
</body>
</html>
