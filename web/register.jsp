<%-- 
    Document   : register
    Created on : Jul 28, 2017, 11:49:55 AM
    Author     : yeekim
--%>
<%@page import="Applications.StudentApplication"%>
<%@page import="Applications.TutorApplication"%>
<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@page import="Models.Tutors"%>
<%@page import="Models.Students"%>
<%@page import="Applications.Validator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <title>Tutor Me! - Register</title>

        <script type="text/javascript">
            var e = document.getElementById("tutorcheck");
            var strUser = e.options[e.selectedIndex].text;
            function tutorCheck() {
                if(strUser.equals("student")){
                    document.getElementById("subjectChoice").disabled=true;
                }
            }
        </script>


    </head>
    <body>
        <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String birthday = request.getParameter("birthday");
        String userType = request.getParameter("userType");
        String subject = request.getParameter("subject");

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
        Tutors tutors = tutorApp.getTutors(); %>
        <div id="headerSection">
            <h1>UTSTutor</h1>
            <div id="headerMenu">
                        <a href="index.jsp">Home</a>
                        <a href="login.jsp">Login</a>
                    </div>
        </div>
        <hr id="divider">
        <div id="registerDiv">
        <h1>Register your TutorMe account.</h1>
        <% if (email == null && password == null) { %>
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
        <% } 
        else if (userType.equals("student")) {                                                          // If user is student, 
            if (studentApp.getStudents().getUser(email) == null) {                                                          // check if user already exists. 

                Student student = new Student(name, email, password, birthday, userType);                       //Create new user according to parameters, update XML file, and activate session. 
                session.setAttribute("tutor", null);
                session.setAttribute("student", student);
                studentApp.getStudents().addUser(student);
                studentApp.addStudent(student);
                response.sendRedirect("main.jsp");
            }
            else { %>
                 <form action="register.jsp" method="POST">
            <table>

                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name" value="<%=name%>"></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email" value="<%=email%>"> </td>
                    <td><p>This student already exists!</p></td>
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password" ></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" value="<%=birthday%>"></td>
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
            <% }
        } 
        else if (userType.equals("tutor")) {
            if (tutors.getUser(email) == null) {
                if (subject.equals("tutorsOnly")) { %>
                     <form action="register.jsp" method="POST">
            <table>
                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name" value="<%=name%>" ></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email" value="<%=email%>"> </td>
              
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" value="<%=birthday%>"></td>
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
                <% } 
                else {
                    String status = "available";
                    Tutor tutor = new Tutor(name, email, password, birthday, userType, subject, status);
                    session.setAttribute("student", null);
                    session.setAttribute("tutor", tutor);
                    tutorApp.addTutor(tutor);
                    response.sendRedirect("main.jsp");
                }
            }
            else { %>
                 <form action="register.jsp" method="POST">
            <table>

                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name" value="<%=name%>"></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email" value="<%=email%>"> </td>
                    <td><p>This tutor already exists!</p></td>
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" value="<%=birthday%>"></td>
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
            <%}
        }%>
        </div>
    </body>
</html>
