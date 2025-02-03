<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="profile.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #00f2fe;
            padding: 15px 30px;
            color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .navbar .logo span {
            font-size: 24px;
            font-weight: bold;
        }
        .navbar .logout {
            background: white;
            color: #00f2fe;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .navbar .logout:hover {
            background: #d4f5fe;
        }
        .container {
            margin: 50px auto;
            max-width: 600px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        h1 {
            text-align: center;
            color: #00f2fe;
        }
        .profile-details p {
            font-size: 16px;
            color: #333;
            margin: 10px 0;
        }
        .profile-details p strong {
            font-weight: bold;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .button-container button {
            flex: 1;
            background: #00f2fe;
            color: white;
            padding: 10px;
            margin: 0 5px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .button-container button:hover {
            background: #4facfe;
        }
        .button-container .delete-profile {
            background: red;
        }
        .button-container .delete-profile:hover {
            background: darkred;
        }
    </style>
</head>
<body>
  <script id="replace_with_navbar" src="nav.js"></script>
    <div class="navbar">
        <div class="logo">
            <span>Club Management</span>
        </div>
        <form action="LogoutServlet" method="post">
            <button type="submit" class="logout">Logout</button>
        </form>
    </div>

    <div class="container">
        <h1>Your Profile</h1>

        <%
            String studentId = (String) session.getAttribute("Student_ID");

            // Initialize variables for user details
            String name = "Not Available";
            String email = "Not Available";
            String contactNumber = "Not Available";
            String faculty = "Not Available";
            String program = "Not Available";

            if (studentId != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");

                    String sql = "SELECT Name, Email, Contact_Num, Faculty, Program FROM student WHERE Student_ID = ?";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, studentId);

                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        name = rs.getString("Name");
                        email = rs.getString("Email");
                        contactNumber = rs.getString("Contact_Num");
                        faculty = rs.getString("Faculty");
                        program = rs.getString("Program");
                    }

                    rs.close();
                    pst.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                response.sendRedirect("Login.jsp");
            }
        %>

        <div class="profile-details">
            <p><strong>Student ID:</strong> <%= studentId %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Contact Number:</strong> <%= contactNumber %></p>
            <p><strong>Faculty:</strong> <%= faculty %></p>
            <p><strong>Program:</strong> <%= program %></p>
        </div>

        <div class="button-container">
            <form action="UpdateProfile.jsp" method="get">
                <button type="submit">Update Profile</button>
            </form>
            <form action="DeleteProfileServlet" method="post">
                <input type="hidden" name="student_id" value="<%= studentId %>">
                <button type="submit" class="delete-profile">Delete Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
