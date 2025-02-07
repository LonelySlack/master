<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to TCMS</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            background-image: url('https://www.google.com/url?sa=i&url=https%3A%2F%2Fsebenarnya.my%2Fuitm%2F&psig=AOvVaw3s_TTQmKU0TD-H-ju8iM2K&ust=1739040050027000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKCMk5absosDFQAAAAAdAAAAABAE') no-repeat center center fixed;
            background-size: cover;
        }

        /* Container Styling */
        .container {
            text-align: center;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            animation: fadeIn 1.5s ease-in-out;
        }

        /* Heading Styling */
        h1 {
            font-size: 3rem;
            color: #00f2fe;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* Subheading Styling */
        p {
            font-size: 1.2rem;
            line-height: 1.6;
            margin-bottom: 30px;
            color: #555;
        }

        /* Button Styling */
        .btn {
            display: inline-block;
            background-color: #00f2fe;
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1rem;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin: 10px;
        }

        .btn:hover {
            background-color: #4facfe;
            transform: scale(1.05);
        }

        .btn-secondary {
            background-color: #ff7e5f;
        }

        .btn-secondary:hover {
            background-color: #ff5c38;
        }

        /* Links Styling */
        .links {
            margin-top: 20px;
        }

        .links a {
            margin: 0 10px;
            text-decoration: none;
            color: #00f2fe;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .links a:hover {
            color: #4facfe;
            text-decoration: underline;
        }

        /* Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to TCMS</h1>
        <p>
            The <strong>TCMS (Technology Club Management System)</strong> is designed to help students manage club activities, events, and memberships efficiently. 
            Join us to explore exciting opportunities and enhance your skills!
        </p>
        <a href="Login.jsp" class="btn">Login</a>
      
    </div>
</body>
</html>