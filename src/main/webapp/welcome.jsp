<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Welcome Dashboard</title>
<link rel="stylesheet" href="dashboard.css">
<link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
<style>
    /* General Styling */
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #4facfe, #00f2fe);
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
    .navbar .logo img {
        max-width: 50px;
        margin-right: 10px;
        vertical-align: middle;
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
    .welcome {
        text-align: center;
        margin: 40px 0;
        color: white;
    }
    .welcome h1 {
        font-size: 36px;
    }
    /* Slideshow Styling */
    .slideshow-container {
        position: relative;
        max-width: 800px;
        margin: 20px auto;
        overflow: hidden;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }
    .slide {
        display: none;
        text-align: center;
        background: white;
        padding: 20px;
        border-radius: 10px;
    }
    .slide.active {
        display: block;
    }
    .slide h3 {
        color: #00f2fe;
        margin-bottom: 10px;
    }
    .slide p {
        color: #666;
    }
    .slide img {
        width: 100%;
        border-radius: 10px;
        max-height: 300px;
        object-fit: cover;
    }
    .slideshow-buttons {
        position: absolute;
        top: 50%;
        width: 100%;
        display: flex;
        justify-content: space-between;
        transform: translateY(-50%);
    }
    .slideshow-buttons button {
        background: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        padding: 10px;
        cursor: pointer;
        border-radius: 50%;
        font-size: 18px;
        transition: background 0.3s ease;
    }
    .slideshow-buttons button:hover {
        background: rgba(0, 0, 0, 0.8);
    }
    .cards {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin: 20px 30px;
        flex-wrap: wrap;
    }
    .card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 20px;
        text-align: center;
        flex: 1;
        max-width: 300px;
        min-width: 200px;
    }
    .card h3 {
        color: #00f2fe;
        margin-bottom: 10px;
    }
    .card p {
        color: #666;
    }
    .card a {
        display: inline-block;
        margin-top: 10px;
        padding: 8px 15px;
        background: #00f2fe;
        color: white;
        border-radius: 5px;
        text-decoration: none;
        font-size: 14px;
        transition: background 0.3s ease;
    }
    .card a:hover {
        background: #4facfe;
    }
</style>
</head>
<body>
    <script id="replace_with_navbar" src="nav.js"></script>
     <%
        // Retrieve Student_ID from session
        String studentId = (String) session.getAttribute("Student_ID");
        String studentName = "Guest"; // Default name
        if (studentId != null) {
            // Database connection details
            String DB_URL = "jdbc:mysql://localhost:3306/clubmanagementsystem?useSSL=false";
            String DB_USER = "root";
            String DB_PASSWORD = "root";
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.jdbc.Driver");
                // Establish Database Connection
                con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                // Query to fetch student name
                String sql = "SELECT Name FROM Student WHERE Student_ID = ?";
                pst = con.prepareStatement(sql);
                pst.setString(1, studentId);
                rs = pst.executeQuery();
                if (rs.next()) {
                    studentName = rs.getString("Name");
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Close database resources
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            }
        }
    %>
   
    <div class="welcome">
        <h1>Welcome, <%= studentName %>!</h1>
        </div>
    <!-- Slideshow Container -->
    <div class="slideshow-container">
        <%
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            boolean hasEvents = false;
            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.jdbc.Driver");
                // Establish Database Connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clubmanagementsystem", "root", "root");
                // Fetch upcoming events
                String query = "SELECT Event_ID, Event_Name, Event_Desc, Event_Date FROM event WHERE Event_Status = 'Scheduled' ORDER BY Event_Date ASC LIMIT 3";
                pst = con.prepareStatement(query);
                rs = pst.executeQuery();

                while (rs.next()) {
                    hasEvents = true;
                    int eventId = rs.getInt("Event_ID");
                    String eventName = rs.getString("Event_Name");
                    String eventDesc = rs.getString("Event_Desc");
                    java.sql.Date eventDate = rs.getDate("Event_Date");
        %>
        <div class="slide">
         
            <h3><%= eventName %></h3>
            <p><%= eventDesc.length() > 100 ? eventDesc.substring(0, 100) + "..." : eventDesc %></p>
            <p><strong>Date:</strong> <%= eventDate %></p>
            <a href="vieweventdetails.jsp?Event_ID=<%= eventId %>" style="background: #00f2fe; color: white; padding: 8px 15px; border-radius: 5px; text-decoration: none;">View Details</a>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            }

            if (!hasEvents) {
        %>
        <div class="slide">
            <img src="no_event.jpg" alt="No Events">
            <h3>No Upcoming Events</h3>
            <p>Stay tuned for future updates!</p>
        </div>
        <%
            }
        %>
        <!-- Navigation Buttons -->
        <div class="slideshow-buttons">
            <button id="prevSlide">&#9664;</button>
            <button id="nextSlide">&#9654;</button>
        </div>
    </div>
    <div class="cards">
        <div class="card">
            <h3>View Clubs</h3>
            <p>Explore all the clubs available at your university.</p>
            <a href="viewclub.jsp">Go to Clubs</a>
        </div>
        <div class="card">
            <h3>Apply for a Club</h3>
            <p>Join a new club that matches your interests.</p>
            <a href="ApplyClub.jsp">Apply Now</a>
        </div>
        <div class="card">
            <h3>Events</h3>
            <p>Stay updated on upcoming events and activities.</p>
            <a href="Event.jsp">View Events</a>
        </div>
        <div class="card">
            <h3>My Profile</h3>
            <p>View and update your profile information.</p>
            <a href="Profile.jsp">Go to Profile</a>
        </div>
    </div>
    <!-- JavaScript for Slideshow -->
    <script>
        const slides = document.querySelectorAll(".slide");
        let currentSlide = 0;

        // Show the first slide initially
        if (slides.length > 0) {
            slides[currentSlide].classList.add("active");
        }

        document.getElementById("prevSlide").addEventListener("click", () => {
            if (slides.length > 0) {
                slides[currentSlide].classList.remove("active");
                currentSlide = (currentSlide - 1 + slides.length) % slides.length;
                slides[currentSlide].classList.add("active");
            }
        });

        document.getElementById("nextSlide").addEventListener("click", () => {
            if (slides.length > 0) {
                slides[currentSlide].classList.remove("active");
                currentSlide = (currentSlide + 1) % slides.length;
                slides[currentSlide].classList.add("active");
            }
        });
    </script>
</body>
</html>