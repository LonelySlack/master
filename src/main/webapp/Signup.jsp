<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
</head>
<body>
    <h1>Sign Up</h1>
    <form action="SignupServlet" method="post">
        <label for="student_id">Student ID:</label>
        <input type="text" id="student_id" name="student_id" required><br><br>

        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="cont_num">Contact Number:</label>
        <input type="text" id="cont_num" name="cont_num" required><br><br>

        <label for="faculty">Faculty:</label>
        <input type="text" id="faculty" name="faculty" required><br><br>

        <label for="program">Program:</label>
        <input type="text" id="program" name="program" required><br><br>

        <label for="ic_num">IC Number:</label>
        <input type="text" id="ic_num" name="ic_num" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <button type="submit">Sign Up</button>
    </form>
</body>
</html>
