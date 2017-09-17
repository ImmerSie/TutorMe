<%-- 
    Document   : Welcome
    Created on : Sep 10, 2017, 10:41:13 PM
    Author     : Mango
--%>

<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@page import="Models.Tutors"%>
<%@page import="Models.Students"%>
<%@page contentType="text/html" import="java.util.*"contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String birthday = request.getParameter("birthday");
        String userType = request.getParameter("userType");
        String subject = request.getParameter("subject");
    %>

    <% String filePath = application.getRealPath("WEB-INF/students.xml");%>
    <% String filePath2 = application.getRealPath("WEB-INF/tutors.xml");%>
    
    <jsp:useBean id="studentApp" class="Applications.StudentApplication" scope="application">
        <jsp:setProperty name="studentApp" property="filePath" value="<%=filePath%>"/>
    </jsp:useBean>
    <%Students students = studentApp.getStudents();%>
    
    <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
        <jsp:setProperty name="tutorApp" property="filePath" value="<%=filePath2%>"/>
    </jsp:useBean>
    <%Tutors tutors = tutorApp.getTutors();%>


    <body>
        <%if (userType.equals("student")) {     
             if (students.getUser(email) == null) {%>

        <p>Welcome, <%= name%>.</p>
        <p>Your Email is <%= email%>. </p>
        <p>Your password is <%= password%>. </p>
        <p>Your birthday is <%= birthday%>. </p>
        <p>You are a <%= userType%>. </p>
        
          <p> Click<a href="main.jsp"> here</a> to go to your main page. </p>

        <%
            Student student = new Student (name, email, password, birthday, userType);
            session.setAttribute("tutor", null);
            session.setAttribute("student", student);
            students.addUser(student);
            studentApp.updateXML(students, filePath);
        }else{%>
        
        <p>This student <%=email%> already exists.</p>
        <p>Click<a href="register.jsp"> here</a> to go back</p>
        <%} }else if (userType.equals("tutor")) { 
             if (tutors.getUser(email) == null) {%>(%>
             
             <p>Welcome, <%= name%>.</p>
             <p>Your Email is <%= email%>. </p>
             <p>Your password is <%= password%>. </p>
             <p>Your birthday is <%= birthday%>. </p>
             <p>You are a <%= userType%>. </p>
             <p>You are teaching <%= subject%>. </p>
               <p> Click<a href="main.jsp"> here</a> to go to your main page. </p>
        
        <%
            String status = "Available";
            Tutor tutor = new Tutor (name, email, password, birthday, userType, subject, status);
            session.setAttribute("student", null);
            session.setAttribute("tutor", tutor);
            tutors.addUser(tutor);
            tutorApp.updateXML(tutors, filePath2);
            
            
           }else{%>
           <p>This tutor <%=email%> already exists.</p>
           <p>Click<a href="register.jsp"> here</a> to go back</p>
           
          <%} } %>


    </body>
</html>
