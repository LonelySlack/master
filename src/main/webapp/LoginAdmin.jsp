<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login</title>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #4facfe, #00f2fe);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .wrapper {
        background: #ffffff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        width: 100%;
        text-align: center;
    }

    .wrapper h1 {
        color: #00f2fe;
        margin-bottom: 20px;
    }

    .form-field {
        margin-bottom: 20px;
    }

    .form-field input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
    }

    .btn {
        width: 100%;
        background: #00f2fe;
        border: none;
        color: #fff;
        font-size: 16px;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn:hover {
        background: #4facfe;
    }

    .error-message {
        color: red;
        font-size: 14px;
        margin-bottom: 10px;
    }
</style>
</head>
<body>
    <div class="wrapper">
        <h1>Admin Login</h1>
        
        <!-- Display error message dynamically -->
        <div class="error-message">
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) { 
            %>
                <%= errorMessage %>
            <% } %>
        </div>

        <form action="AdminLoginServlet" method="post">
            <div class="form-field">
                <input type="text" name="Admin_ID" placeholder="Admin ID" required>
            </div>
            <div class="form-field">
                <input type="password" name="Admin_Password" placeholder="Password" required>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
    </div>
</body>
</html>
