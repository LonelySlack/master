<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="profile.css">
    <link rel="icon" type="image/x-icon"
        href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
        }
        .profile-navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #00f2fe;
            padding: 15px 30px;
            color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .profile-navbar .logo span {
            font-size: 24px;
            font-weight: bold;
        }
        .profile-navbar .logout {
            background: white;
            color: #00f2fe;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .profile-navbar .logout:hover {
            background: #d4f5fe;
        }
        .profile-container {
            margin: 50px auto;
            max-width: 600px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .profile-h1 {
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
        .profile-button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .profile-button-container button {
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
        .profile-button-container button:hover {
            background: #4facfe;
        }
        .profile-button-container .delete-profile {
            background: red;
        }
        .profile-button-container .delete-profile:hover {
            background: darkred;
        }
    </style>
</head>
<body>
    <%-- Retrieve Role_ID from clubmember table --%>
    <%
        String studentId = (String) session.getAttribute("Student_ID");
        String roleIdNumeric = "2"; // Default role (member)
        String roleName = "member"; // Default role name

        String DB_URL = "jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC";
        String DB_USER = "u9946_Kmmw1Vvrcg";
        String DB_PASSWORD = "V6y2rsxfO0B636FUWqU^Ia=F";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Fetch Role_ID from clubmember table
            String roleQuery = "SELECT Role_ID FROM club_member WHERE Student_ID = ?";
            PreparedStatement pst = con.prepareStatement(roleQuery);
            pst.setString(1, studentId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                roleIdNumeric = rs.getString("Role_ID"); // Get numeric Role_ID
                // Map numeric Role_ID to role name
                if ("1".equals(roleIdNumeric)) {
                    roleName = "president";
                } else if ("2".equals(roleIdNumeric)) {
                    roleName = "member";
                }
            }

            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <%-- Load navbar properly --%>
    <%
        if ("president".equals(roleName)) {
            // President role: Load admin navbar
    %>
    <script id="replace_with_presidentnavbar" src="presidentnavbar.js"></script>
    <%
        } else {
            // Member role: Load standard navbar
    %>
    <script id="replace_with_navbar" src="nav.js"></script>
    <%
        }
    %>

    <%-- Retrieve session details --%>
    <%
        // Initialize user details
        String name = "Not Available";
        String email = "Not Available";
        String contactNumber = "Not Available";
        String faculty = "Not Available";
        String program = "Not Available";
        String clubNames = "No club joined";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Fetch user profile details from the database
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

            // Fetch clubs the student has joined
            String clubsQuery = "SELECT c.Club_Name FROM club_member cm " +
                                "JOIN club c ON cm.Club_ID = c.Club_ID " +
                                "WHERE cm.Student_ID = ? AND cm.Member_Status = 'Active'";
            pst = con.prepareStatement(clubsQuery);
            pst.setString(1, studentId);
            rs = pst.executeQuery();
            StringBuilder clubs = new StringBuilder();
            while (rs.next()) {
                if (clubs.length() > 0) {
                    clubs.append(", ");
                }
                clubs.append(rs.getString("Club_Name"));
            }
            if (clubs.length() > 0) {
                clubNames = clubs.toString();
            }

            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    
    <div class="profile-container">
        <h1 class="profile-h1">Profile</h1>
        <div class="profile-details">
            <p><strong>Student ID:</strong> <%= studentId %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Contact Number:</strong> <%= contactNumber %></p>
            <p><strong>Faculty:</strong> <%= faculty %></p>
            <p><strong>Program:</strong> <%= program %></p>
            <p><strong>Clubs Joined:</strong> <%= clubNames %></p>
        </div>
        <div class="profile-button-container">
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