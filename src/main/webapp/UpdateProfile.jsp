<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link rel="stylesheet" href="form.css">
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <script>
        const facultyPrograms = {
            "FACULTY OF ACCOUNTANCY": [
                "DIPLOMA IN ACCOUNTING INFORMATION SYSTEM (AC120)",
                "DIPLOMA IN ACCOUNTANCY (AC110)",
                "FOUNDATION IN ACCOUNTANCY - ACCA FIA (AC151)"
            ],
            "FACULTY OF APPLIED SCIENCES": [
                "DIPLOMA IN SCIENCE (AS120)"
            ],
            "COLLEGE OF COMPUTING, INFORMATICS AND MATHEMATICS": [
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

            // Populate program dropdown based on selected faculty
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

            // Pre-select faculty and program from server data
            const selectedFaculty = `<%= (String) session.getAttribute("Faculty") != null ? session.getAttribute("Faculty") : "" %>`;
            const selectedProgram = `<%= (String) session.getAttribute("Program") != null ? session.getAttribute("Program") : "" %>`;

            if (selectedFaculty) {
                facultyDropdown.value = selectedFaculty;

                // Trigger change event to populate programs for the selected faculty
                facultyDropdown.dispatchEvent(new Event('change'));

                // Pre-select program after the dropdown is populated
                setTimeout(() => {
                    if (selectedProgram) {
                        programDropdown.value = selectedProgram;
                    }
                }, 100);
            }
        };
    </script>
</head>
<body>
    <script id="replace_with_navbar" src="nav.js"></script>
    <div class="wrapper">
        <div class="text-center mt-4 name">
            <h2 style="text-align:center;">Update Your Profile</h2>
        </div>
        <%
            // Fetch user details from session
            String studentId = (String) session.getAttribute("Student_ID");
            String name = (String) session.getAttribute("Student_Name");
            String email = (String) session.getAttribute("Email");
            String contactNumber = (String) session.getAttribute("Contact_Num");
            String faculty = (String) session.getAttribute("Faculty");
            String program = (String) session.getAttribute("Program");
            String status = (String) session.getAttribute("Status");
        %>
        <form action="ProfileServlet" method="post">
            <!-- Hidden Student ID -->
            <input type="hidden" name="student_id" value="<%= studentId %>">
            
            <!-- Name -->
            <label for="name">Name</label>
            <div class="form-field">
                <input type="text" id="name" name="name" placeholder="Enter Name" value="<%= name != null ? name : "" %>" required>
            </div>

            <!-- Email -->
            <label for="email">Email</label>
            <div class="form-field">
                <input type="email" id="email" name="email" placeholder="Enter Email" value="<%= email != null ? email : "" %>" required>
            </div>

            <!-- Contact Number -->
            <label for="contactNumber">Contact Number</label>
            <div class="form-field">
                <input type="text" id="contactNumber" name="contactNumber" placeholder="Enter Contact Number" value="<%= contactNumber != null ? contactNumber : "" %>" required>
            </div>

            <!-- Faculty -->
            <label for="faculty">Faculty</label>
            <div class="form-field">
                <select name="faculty" id="faculty" required>
                    <option value="">Select Faculty</option>
                    <option value="FACULTY OF ACCOUNTANCY">FACULTY OF ACCOUNTANCY</option>
                    <option value="FACULTY OF APPLIED SCIENCES">FACULTY OF APPLIED SCIENCES</option>
                    <option value="COLLEGE OF COMPUTING, INFORMATICS AND MATHEMATICS">
                        COLLEGE OF COMPUTING, INFORMATICS AND MATHEMATICS
                    </option>
                </select>
            </div>

            <!-- Program -->
            <label for="program">Program</label>
            <div class="form-field">
                <select name="program" id="program" required>
                    <option value="">Select Program</option>
                </select>
            </div>

            <!-- Status -->
            <label for="status">Status</label>
            <div class="form-field">
                <input type="text" id="status" name="status" placeholder="Enter Status" value="<%= status != null ? status : "" %>" required>
            </div>

            <!-- Submit Button -->
            <button type="submit" name="action" class="btn" value="update">Save Changes</button>
        </form>
    </div>
</body>
</html>
