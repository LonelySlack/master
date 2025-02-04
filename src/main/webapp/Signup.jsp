<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="form.css">
    <link rel="icon" type="image/x-icon"
        href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <script>
        // ✅ Client-side validation for email format
        function validateForm() {
            const email = document.getElementById("email").value;
            const regex = /^[a-zA-Z0-9._-]+@student\.uitm\.edu\.my$/; // Validate UiTM email format
            if (!regex.test(email)) {
                alert("❌ Please enter a valid UiTM student email.");
                return false;
            }
            return true;
        }

        // ✅ Faculty and Program dynamic selection
        const facultyPrograms = {
            "Faculty of Accountancy": [
                "DIPLOMA IN ACCOUNTING INFORMATION SYSTEM (AC120)",
                "DIPLOMA IN ACCOUNTANCY (AC110)",
                "FOUNDATION IN ACCOUNTANCY - ACCA FIA (AC151)"
            ],
            "Faculty of Applied Sciences": [
                "DIPLOMA IN SCIENCE (AS120)"
            ],
            "College of Computing, Informatics and Mathematics": [
                "DIPLOMA IN COMPUTER SCIENCE (CS110)",
                "DIPLOMA IN STATISTICS (CS111)",
                "DIPLOMA IN ACTUARIAL SCIENCE (CS112)",
                "DIPLOMA IN MATHEMATICAL SCIENCES (CS143)",
                "BACHELOR OF COMPUTER SCIENCE (HONOURS) (CS230)"
            ]
        };

        window.onload = function () {
            const facultyDropdown = document.getElementById('faculty');
            const programDropdown = document.getElementById('program');

            facultyDropdown.addEventListener('change', function () {
                const selectedFaculty = facultyDropdown.value;
                programDropdown.innerHTML = '<option value="">Select Program</option>';
                if (selectedFaculty && facultyPrograms[selectedFaculty]) {
                    facultyPrograms[selectedFaculty].forEach(program => {
                        const option = document.createElement('option');
                        option.value = program;
                        option.textContent = program;
                        programDropdown.appendChild(option);
                    });
                }
            });
        };
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
            <div class="form-container">
                <label for="student_id">Student ID</label>
                <div class="form-field d-flex align-items-center">
                    <input type="text" name="student_id" id="student_id" placeholder="Enter Student ID" required>
                </div>

                <label for="name">Full Name</label>
                <div class="form-field d-flex align-items-center">
                    <input type="text" name="name" id="name" placeholder="Enter Full Name" required>
                </div>

                <label for="email">Email</label>
                <div class="form-field d-flex align-items-center">
                    <input type="email" name="email" id="email" placeholder="Enter UiTM Student Email" required>
                </div>

                <label for="cont_num">Contact Number</label>
                <div class="form-field d-flex align-items-center">
                    <input type="text" name="cont_num" id="cont_num" placeholder="Enter Contact Number" required>
                </div>

                <label for="faculty">Faculty</label>
                <div class="form-field d-flex align-items-center">
                    <select name="faculty" id="faculty" required>
                        <option value="">Select Faculty</option>
                        <option value="Faculty of Accountancy">Faculty of Accountancy</option>
                        <option value="Faculty of Applied Sciences">Faculty of Applied Sciences</option>
                        <option value="College of Computing, Informatics and Mathematics">
                            College of Computing, Informatics and Mathematics
                        </option>
                    </select>
                </div>

                <label for="program">Program</label>
                <div class="form-field d-flex align-items-center">
                    <select name="program" id="program" required>
                        <option value="">Select Program</option>
                    </select>
                </div>

                <label for="ic_num">IC Number</label>
                <div class="form-field d-flex align-items-center">
                    <input type="text" name="ic_num" id="ic_num" placeholder="Enter IC Number" required>
                </div>

                <label for="password">Password</label>
                <div class="form-field d-flex align-items-center">
                    <input type="password" name="password" id="password" placeholder="Enter Password" required>
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
