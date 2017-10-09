<%-- 
    Document   : register
    Created on : Jul 28, 2017, 11:49:55 AM
    Author     : yeekim
--%>
<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@page import="Models.Tutors"%>
<%@page import="Models.Students"%>
<%@page import="Applications.Validator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
                <link href="template.css" rel="stylesheet" type="text/css"/>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tutor Me! - Register</title>
    </head>
    
<body>    
    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String birthday = request.getParameter("birthday");
        String userType = request.getParameter("userType");
        String subject = request.getParameter("subject");

        String studentsFilePath = application.getRealPath("WEB-INF/students.xml");
        String tutorFilePath = application.getRealPath("WEB-INF/tutors.xml");%>

    <jsp:useBean id="studentApp" class="Applications.StudentApplication" scope="application">
        <jsp:setProperty name="studentApp" property="filePath" value="<%=studentsFilePath%>"/>
    </jsp:useBean>
    <%Students students = studentApp.getStudents();%>

    <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
        <jsp:setProperty name="tutorApp" property="filePath" value="<%=tutorFilePath%>"/>
    </jsp:useBean>
    <%Tutors tutors = tutorApp.getTutors();%>
    
    <div id="headerSection">
            <h1>UTSTutor</h1>
        </div>
        <hr>
        <div id="registerDiv">
    
        <%if (email == null && password == null) {%>
        <h1>Register your Tutor Me account.</h1>


        <form action="register.jsp" method="POST">
            <table>

                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name"></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email"> </td>
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" default="DD-MM-YYYY"></td>
                </tr>
                <tr>
                    <td>User Type:</td> 
                    <td><select name="userType" id="tutorCheck">
                            <option value="student">Student</option>
                            <option value="tutor">Tutor</option>

                        </select></td>
                </tr>
                <tr> 
                    <td>Subject</td> 
                    <td><select name="subject" id="subjectChoice">
                            <option value="tutorsOnly">Tutors Only</option>
                            <option value="WSD">WSD</option>
                            <option value="USP">USP</option>
                            <option value="SEP">SEP</option>
                            <option value="AppProg">AppProg</option>
                            <option value="MobileApp">MobileApp</option>
                        </select></td>
                </tr>
                <tr>
                    <td></td> 
                    <td><input type="submit" value="Register" name="Register"></td> 
                </tr>
            </table>
        </form>

        <hr>
        <p> Click <a href="login.jsp">here</a> to login. </p>
        <p> Click <a href="index.jsp">here</a> for the main page. </p>
        <%} else if (userType.equals("student")) {                                                          // If user is student, 
            if (students.getUser(email) == null) {                                                          // check if user already exists. 

                Student student = new Student(name, email, password, birthday, userType);                       //Create new user according to parameters, update XML file, and activate session. 
                session.setAttribute("tutor", null);
                session.setAttribute("student", student);
                students.addUser(student);
                // studentApp.updateXML(students, filePath);
                studentApp.addStudent(student);
                response.sendRedirect("main.jsp");

        %>

        <%} else {%>

        <h1>Register your Tutor Me account.</h1>
        <form action="register.jsp" method="POST">
            <table>

                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name"></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email"> </td>
                    <td><p>This student already exists!</p></td>
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" default="DD-MM-YYYY"></td>
                </tr>
                <tr>
                    <td>User Type:</td> 
                    <td><select name="userType" id="tutorCheck">
                            <option value="student">Student</option>
                            <option value="tutor">Tutor</option>

                        </select></td>
                </tr>
                <tr> 
                    <td>Subject</td> 
                    <td><select name="subject" id="subjectChoice">
                            <option value="tutorsOnly">Tutors Only</option>
                            <option value="WSD">WSD</option>
                            <option value="USP">USP</option>
                            <option value="SEP">SEP</option>
                            <option value="AppProg">AppProg</option>
                            <option value="MobileApp">MobileApp</option>
                        </select></td>
                </tr>
                <tr>
                    <td></td> 
                    <td><input type="submit" value="Register" name="Register"></td> 
                </tr>
            </table>
        </form>

        <hr>
        <p> Click <a href="login.jsp">here</a> to login. </p>
                <p> Click <a href="index.jsp">here</a> for the main page. </p>
        
        <%}
        } else if (userType.equals("tutor")) {
            if (tutors.getUser(email) == null) {
                if (subject.equals("tutorsOnly")) { %>
        <h1>Register your Tutor Me account.</h1>


        <form action="register.jsp" method="POST">
            <table>
                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name"></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email"> </td>
              
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" default="DD-MM-YYYY"></td>
                </tr>
                <tr>
                    <td>User Type:</td> 
                    <td><select name="userType" id="tutorCheck">
                            <option value="student">Student</option>
                            <option value="tutor">Tutor</option>

                        </select></td>
                </tr>
                <tr> 
                    <td>Subject</td> 
                    <td><select name="subject" id="subjectChoice">
                            <option value="tutorsOnly">Tutors Only</option>
                            <option value="WSD">WSD</option>
                            <option value="USP">USP</option>
                            <option value="SEP">SEP</option>
                            <option value="AppProg">AppProg</option>
                            <option value="MobileApp">MobileApp</option>
                        </select></td>
                              <td><p>Tutors must choose a subject!</p></td>
                </tr>
                <tr>
                    <td></td> 
                    <td><input type="submit" value="Register" name="Register"></td> 
                </tr>
            </table>
        </form>

        <hr>
        <p> Click <a href="login.jsp">here</a> to login. </p>
                <p> Click <a href="index.jsp">here</a> for the main page. </p>
        <%   } else {

                String status = "available";
                Tutor tutor = new Tutor(name, email, password, birthday, userType, subject, status);
                session.setAttribute("student", null);
                session.setAttribute("tutor", tutor);
                //tutors.addUser(tutor);
                // tutorApp.updateXML(tutors, filePath2);
                tutorApp.addTutor(tutor);
                response.sendRedirect("main.jsp");

                 }

             } else {%>
        <h1>Register your Tutor Me account.</h1>


        <form action="register.jsp" method="POST">
            <table>

                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name"></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email"> </td>
                    <td><p>This tutor already exists!</p></td>
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" default="DD-MM-YYYY"></td>
                </tr>
                <tr>
                    <td>User Type:</td> 
                    <td><select name="userType" id="tutorCheck">
                            <option value="student">Student</option>
                            <option value="tutor">Tutor</option>

                        </select></td>
                </tr>
                <tr> 
                    <td>Subject</td> 
                    <td><select name="subject" id="subjectChoice">
                            <option value="tutorsOnly">Tutors Only</option>
                            <option value="WSD">WSD</option>
                            <option value="USP">USP</option>
                            <option value="SEP">SEP</option>
                            <option value="AppProg">AppProg</option>
                            <option value="MobileApp">MobileApp</option>
                        </select></td>
                </tr>
                <tr>
                    <td></td> 
                    <td><input type="submit" value="Register" name="Register"></td> 
                </tr>
            </table>
        </form>

        <hr>
        <p> Click <a href="login.jsp">here</a> to login. </p>
        <p> Click <a href="index.jsp">here</a> for the main page. </p>

        <%}
            }%>

            </div>

    </body>
</html>



