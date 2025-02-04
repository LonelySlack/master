<%
    // Check if the built-in session exists and invalidate it
    if (session != null) {
        session.invalidate(); // Destroy the session
    }
    // Redirect to login page after logout
    response.sendRedirect("Login.jsp");
%>
