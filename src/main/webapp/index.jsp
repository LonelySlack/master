<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>
    <h2>Database Connection Test</h2>
    <form action="testConnection" method="POST">
        <input type="submit" value="Test Database Connection">
    </form>

    <%
        // Display any message passed from the servlet
        String message = (String) request.getAttribute("message");
        if (message != null) {
            out.println("<p>" + message + "</p>");
        }
    %>
</body>
</html>