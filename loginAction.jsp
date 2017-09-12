<%-- 
    Document   : loginAction
    Created on : Sep 10, 2017, 11:41:35 PM
    Author     : Mango
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%

        String email = request.getParameter("email");
        String password = request.getParameter("password");


    %>



    <body>
        <% String filePath = application.getRealPath("WEB-INF/users.xml");%>

        
        <jsp:useBean id="diaryApp" class="uts.wsd.DiaryApplication" scope="application">
            <jsp:setProperty name="diaryApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>

        <%
            Users users = diaryApp.getUsers();
            User user = users.login(email, password);
        %>

        <% if (user != null) {
                session.setAttribute("user", user);
        %>

        <p>Login successful. Click <a href="index.jsp">here </a>to return to the main page.</p>
        <% } else { %>
        <p>Password incorrect. Click <a href="login.jsp">here </a>to return to the main page. </p>

        <% }%>

    </body>
</html>
