<%-- 
    Document   : Welcome
    Created on : Sep 10, 2017, 10:41:13 PM
    Author     : Mango
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    
    
    
    
    <body>
        
        <p>Welcome, <%= name%>.</p>
        <p>Your Email is <%= email%>. </p>
        <p>Your password is <%= password%>. </p>
        <p>Your birthday is <%= birthday%>. </p>
        <p>You are a <%= userType%>. </p>
        
        <p> Click<a href="main.jsp">here</a> to go to your main page. </p>
        
        
        <%if(userType.equals("Student")){ 
        
            <%Students students = diaryApp.getStudents();%>
            Student student = new Student(name, email, password, birthday, userType);
            session.setAttribute("student", student);
            students.addUser(student);
            diaryApp.saveUsers();

        

        

        }else{
        
        
        
        }
        
        %>
        
        
    </body>
</html>
