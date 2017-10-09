<%-- 
    Document   : login
    Created on : Sep 10, 2017, 9:21:22 PM
    Author     : Mango
--%>

<%@page import="Applications.StudentApplication"%>
<%@page import="Applications.TutorApplication"%>
<%@page import="Models.Tutor"%>
<%@page import="Models.Tutors"%>
<%@page import="Models.Student"%>
<%@page import="Models.Students"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <title>Tutor Me!-Login</title>
    </head>
    <%

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String passCheck = "";
        String userCheck = "";
    %>

    <body>
        <%
        if(session.getAttribute("studentApp") == null){
            String studentsFilePath = application.getRealPath("WEB-INF/students.xml");
            %> <jsp:useBean id="studentApp" class="Applications.StudentApplication" scope="session">
                <jsp:setProperty name="studentApp" property="filePath" value="<%=studentsFilePath%>"/>
            </jsp:useBean> <%
        }
        if(session.getAttribute("tutorApp") == null){
            String tutorFilePath = application.getRealPath("WEB-INF/tutors.xml");
            %> <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="session">
                <jsp:setProperty name="tutorApp" property="filePath" value="<%=tutorFilePath%>"/>
            </jsp:useBean> <%
        } 
        TutorApplication tutorApp = (TutorApplication) session.getAttribute("tutorApp");
        StudentApplication studentApp = (StudentApplication) session.getAttribute("studentApp");
        %>  
        <div id="headerSection">
            <h1>UTSTutor</h1>
        </div>
        <hr>
        <div id="loginDiv">
            <% if (email == null && password == null) { %>
            <h1>Login</h1>
            <form action="login.jsp" method="POST">
                <table>

                    <tr>
                        <td>Email:</td> 
                        <td><input type="text" name="email"> </td>
                        <td></td>
                    </tr>
                    <tr> 
                        <td>Password:</td> 
                        <td><input type="password" name="password"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td> 
                        <td><input type="submit" value="Login" name="Login"></td> 

                    </tr>
                </table>
            </form>
            <hr>
            <p> Click <a href="register.jsp">here </a>to register. </p>
            <%} else {
                Students students = studentApp.getStudents();                               //Fetch current students and tutors. 
                Student student = students.login(email, password);
                Student studentExist = students.getUser(email);

                Tutors tutors = tutorApp.getTutors();
                Tutor tutor = tutors.login(email, password);
                Tutor tutorExist = tutors.getUser(email);

                if ((studentExist != null && student == null) || tutorExist != null && tutor == null) {                                         //Checks is password is incorrect
                    %>             
                    <h1>Login</h1>
                    <form action="login.jsp" method="POST">
                        <table>

                            <tr>
                                <td>Email:</td> 
                                <td><input type="text" name="email"> </td>

                            </tr>
                            <tr> 
                                <td>Password:</td> 
                                <td><input type="password" name="password"></td>
                                <td><p>Password Incorrect</p></td>
                            </tr>
                            <tr>
                                <td></td> 
                                <td><input type="submit" value="Login" name="Login"></td> 

                            </tr>
                        </table>
                    </form>
                    <hr>
                    <p> Click <a href="register.jsp">here </a>to register. </p>
                <%} else if (studentExist == null || tutorExist == null) { %>
                <h1>Login</h1>
                <form action="login.jsp" method="POST">
                    <table>

                        <tr>
                            <td>Email:</td> 
                            <td><input type="text" name="email"> </td>
                            <td><p>User doesn't exist.</p></td>
                        </tr>
                        <tr> 
                            <td>Password:</td> 
                            <td><input type="password" name="password"></td>

                        </tr>
                        <tr>
                            <td></td> 
                            <td><input type="submit" value="Login" name="Login"></td> 

                        </tr>
                    </table>
                </form>
                <hr>
                <p> Click <a href="register.jsp">here </a>to register. </p>
            <% }

            if (student != null) {                                                       // Upon successful match, activate session for appropriate user type and redirect to main.jsp
                session.setAttribute("tutor", null);
                session.setAttribute("student", student);
                response.sendRedirect("main.jsp");
            } else if (tutor != null) {
                session.setAttribute("student", null);
                session.setAttribute("tutor", tutor);
                response.sendRedirect("main.jsp");
            }
        } %>
        </div>
    </body>
</html>
