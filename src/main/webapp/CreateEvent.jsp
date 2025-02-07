<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
        }
        .wrapper {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .wrapper h1 {
            text-align: center;
            color: #00f2fe;
            margin-bottom: 20px;
        }
        .form-field {
            margin-bottom: 15px;
        }
        .form-field label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        .form-field input, .form-field textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-field textarea {
            resize: none;
            height: 100px;
        }
        .form-field button {
            width: 100%;
            padding: 10px;
            background: #00f2fe;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .form-field button:hover {
            background: #4facfe;
        }
        .back-button {
            display: block;
            width: 100px;
            margin: 20px auto;
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
        }
        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<script id="replace_with_presidentnavbar" src="presidentnavbar.js"></script>
    <div class="wrapper">
        <h1>Create Event</h1>

        <% 
            // ✅ Validate session and Club_ID
            if (session == null || session.getAttribute("Student_ID") == null || session.getAttribute("Club_ID") == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            // ✅ Ensure Club_ID is retrieved properly
            int clubId = -1;
            Object clubIdObj = session.getAttribute("Club_ID");
            
            if (clubIdObj != null) {
                try {
                    clubId = Integer.parseInt(clubIdObj.toString());
                } catch (NumberFormatException e) {
                    response.sendRedirect("Login.jsp");
                    return;
                }
            }

            // ✅ Ensure Club_ID is valid
            if (clubId == -1) {
                response.sendRedirect("Login.jsp");
                return;
            }
        %>

        <form action="CreateEvent" method="post">
            <div class="form-field">
                <label for="eventName">Event Name</label>
                <input type="text" id="eventName" name="eventName" placeholder="Enter the event name" required>
            </div>
            <div class="form-field">
                <label for="eventDate">Event Date</label>
                <input type="date" id="eventDate" name="eventDate" required min="<%= java.time.LocalDate.now() %>">
            </div>
            <div class="form-field">
                <label for="eventDesc">Event Description</label>
                <textarea id="eventDesc" name="eventDesc" placeholder="Enter a description of the event" required></textarea>
            </div>
            <div class="form-field">
                <label for="eventLocation">Event Location</label>
                <input type="text" id="eventLocation" name="eventLocation" placeholder="Enter the event location" required>
            </div>
            <div class="form-field">
                <label for="maxParticipants">Max Participants</label>
                <input type="number" id="maxParticipants" name="maxParticipants" placeholder="Enter max participants" required min="1">
            </div>
            <div class="form-field">
                <button type="submit">Create Event</button>
            </div>
        </form>
    </div>
    <div><a href="President_home.jsp" class="back-button">Back to Home</a></div>
</body>
</html>
