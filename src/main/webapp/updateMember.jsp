<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Member</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 50px auto;
        }
        h1 {
            text-align: center;
            color: #00f2fe;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #4caf50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Member Details</h1>
        <form action="SaveMemberServlet" method="post">
            <input type="hidden" name="Member_ID" value="<%= request.getAttribute("Member_ID") %>">

            <label for="Member_Status">Member Status</label>
            <input type="text" name="Member_Status" value="<%= request.getAttribute("Member_Status") %>" required>

            <label for="Role_ID">Role ID</label>
            <input type="text" name="Role_ID" value="<%= request.getAttribute("Role_ID") %>" required>

            <label for="Register_Date">Register Date</label>
            <input type="date" name="Register_Date" value="<%= request.getAttribute("Register_Date") %>" required>

            <button type="submit">Save Changes</button>
        </form>
    </div>
</body>
</html>
