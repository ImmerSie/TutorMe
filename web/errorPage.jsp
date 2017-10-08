<%-- 
    Document   : errorPage
    Created on : 08/10/2017, 4:06:07 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Error</h2>
        <h1>404 Page Not Found</h1>
        <%
            session.setAttribute("showSearch", null);
            if(session.getAttribute("student") != null || session.getAttribute("tutor") != null){ %>
                <a href="main.jsp">Return to Main page</a>
            <% } else { %>
                <a href="login.jsp">Go to Login</a>
            <% }
        %>
    </body>
</html>
