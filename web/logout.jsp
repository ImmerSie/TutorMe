<%-- 
    Document   : logout
    Created on : Sep 30, 2017, 6:47:08 PM
    Author     : Mango
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tutor Me</title>
    </head>
    <body>
        <p>You have logged out from your session. Click <a href="index.jsp">here</a> to return to the main page.</p>
        
        <% session.invalidate();                                                    //Terminate active session and redirect user to index.jsp 
        response.sendRedirect("index.jsp"); %>
    </body>
</html>
