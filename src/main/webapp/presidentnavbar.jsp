<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>President Navbar</title>
    <link rel="stylesheet" href="navbar.css">
</head>
<body>
    <%
        // Fetch the Club_ID for the logged-in president
        String studentId = (String) session.getAttribute("Student_ID");
        int clubId = -1; // Default value if no club is found
        boolean isValidSession = false;

        if (studentId != null) {
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://139.99.124.197:3306/s9946_tcms?serverTimezone=UTC", "u9946_Kmmw1Vvrcg", "V6y2rsxfO0B636FUWqU^Ia=F");
                String query = "SELECT Club_ID FROM club WHERE President_ID = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, studentId);
                rs = pst.executeQuery();
                if (rs.next()) {
                    clubId = rs.getInt("Club_ID");
                    isValidSession = true;
                } else {
                    // Redirect to home if no club is found
                    response.sendRedirect("President_home.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            }
        } else {
            // Redirect to login if session is invalid
            response.sendRedirect("Login.jsp");
            return;
        }
    %>

    <!-- Navbar Container -->
    <div class="navbar-container">
        <nav class="navbar">
            <ul class="nav-links">
                <!-- Logo on the left -->
                <li class="logo">
                    <img src="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp" alt="Logo" class="logo-img">
                </li>
                <li><a href="President_home.jsp">Home</a></li>
                <li><a href="President_viewclubdetails.jsp?Club_ID=<%= clubId %>">Club</a></li>
                <li><a href="President_clubevent.jsp?Club_ID=<%= clubId %>">Event</a></li>
            </ul>
            <!-- Profile Dropdown on the far right -->
            <ul class="profile-section">
                <li class="dropdown">
                    <button class="dropbtn">
                        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile" class="profile-icon">
                    </button>
                    <div class="dropdown-content">
                        <a href="Profile.jsp">Profile</a>
                        <a href="LogoutServlet">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
    </div>
</body>
</html>