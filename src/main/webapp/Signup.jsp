<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link rel="stylesheet" href="form.css">
<link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
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
        <h1 style="text-align:center;">SIGN UP</h1>
    </div>
    <form class="p-3 mt-3" action="SignupServlet" method="post" onsubmit="return validateForm()">
        <div class="form-field d-flex align-items-center">
            <label for="student_id" hidden>Student ID</label>
            <input type="text" name="student_id" id="student_id" placeholder="Student ID (e.g., 2021123456)" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="name" hidden>Full Name</label>
            <input type="text" name="name" id="name" placeholder="Full Name" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="ic" hidden>IC Number</label>
            <input type="text" name="ic" id="ic" placeholder="IC Number (e.g., 990101012345)" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="email" hidden>Email</label>
            <input type="email" name="email" id="email" placeholder="UiTM Student Email (e.g., yourid@student.uitm.edu.my)" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="cont_num" hidden>Contact Number</label>
            <input type="text" name="cont_num" id="cont_num" placeholder="Contact Number (e.g., 0123456789)" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="faculty" hidden>Faculty</label>
            <input type="text" name="faculty" id="faculty" placeholder="Faculty (e.g., FSKM)" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="program" hidden>Program</label>
            <input type="text" name="program" id="program" placeholder="Program (e.g., CS240)" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="year" hidden>Year of Study</label>
            <input type="text" name="year" id="year" placeholder="Year of Study (e.g., 2)" required>
        </div>
        <div class="form-field d-flex align-items-center">
            <label for="pwd" hidden>Password</label>
            <input type="password" name="password" id="pwd" placeholder="Password (min 8 characters)" minlength="8" required>
        </div>
        <button type="submit" class="btn mt-3">SIGN UP</button>
    </form>
    <div class="text-center fs-6">
        <p style="text-align:center;"><a href="Login.jsp">Already have an account? Login</a></p>
    </div>
</div>
</body>
</html>
