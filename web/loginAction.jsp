<%-- 
    Document   : loginAction
    Created on : Sep 10, 2017, 11:41:35 PM
    Author     : Mango
--%>

<%@page import="Models.Tutor"%>
<%@page import="Models.Tutors"%>
<%@page import="Models.Student"%>
<%@page import="Models.Students"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%

        String email = request.getParameter("email");
        String password = request.getParameter("password");


    %>



    <body>
        <% 
            String filePath = application.getRealPath("WEB-INF/students.xml");
            String filePath2 = application.getRealPath("WEB-INF/tutors.xml");
        %>

        
    <jsp:useBean id="studentApp" class="Applications.StudentApplication" scope="application">
        <jsp:setProperty name="studentApp" property="filePath" value="<%=filePath%>"/>
    </jsp:useBean>
    
    <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
        <jsp:setProperty name="tutorApp" property="filePath" value="<%=filePath2%>"/>
    </jsp:useBean>

        <%
            Students students = studentApp.getStudents();
            Student student = students.login(email, password);
            
            Tutors tutors = tutorApp.getTutors();
            Tutor tutor = tutors.login(email, password);
        %>

        <% if (student != null) {
                session.setAttribute("student", student);  %>
                <p>Login successful. Click <a href="main.jsp">here </a>to get to the main page.</p>
        <% }else if(tutor != null) {
             session.setAttribute("tutor", tutor); %>
            <p>Login successful. Click <a href="main.jsp">here </a>to get to the main page.</p>
        <% } else { %>
            <p> Username or password is incorrect. Click <a href="login.jsp">here </a>to retry. </p>
            <p> Alternatively, click <a href="register.jsp">here </a>to register. </p>
        <% }%>
        
    </body>
</html>
