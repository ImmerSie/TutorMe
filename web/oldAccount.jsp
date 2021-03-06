<%-- 
    Document   : account
    Created on : Oct 2, 2017, 1:14:14 PM
    Author     : Mango
--%>

<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@page import="Models.Booking"%>

<%@page import="Models.Tutors"%>
<%@page import="Models.Students"%>
<%@page import="Models.Bookings"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TutorMe - Account </title>
    </head>

    <%
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String birthday = request.getParameter("birthday");
        String button = request.getParameter("Edit");
        String cancel = request.getParameter("cancel");
    %>

    <% String studentsFilePath = application.getRealPath("WEB-INF/students.xml");
        String tutorFilePath = application.getRealPath("WEB-INF/tutors.xml");
        String bookingFilePath = application.getRealPath("WEB-INF/bookings.xml");

    %>
    <jsp:useBean id="studentApp" class="Applications.StudentApplication" scope="application">
        <jsp:setProperty name="studentApp" property="filePath" value="<%=studentsFilePath%>"/>
    </jsp:useBean>
    <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
        <jsp:setProperty name="tutorApp" property="filePath" value="<%=tutorFilePath%>"/>
    </jsp:useBean>
    <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
        <jsp:setProperty name="bookingApp" property="filePath" value="<%=bookingFilePath%>"/>
    </jsp:useBean>



    <body>
        <%  Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");

        %>
        <h1>Your Account details</h1>
        <h3>You may edit your details.</h3>

        <% if (cancel == null) {
                if (button == null) {
                    if (student != null) {                                                                          //if current session's user is a student, show their account details
                        //    Student student1 = studentApp.getStudentByName(student.getName()); %>


        <form action="account.jsp" method="POST">
            <table>
                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name" value=<%=student.getName()%>></td> 
                </tr>
                <tr> 
                    <td>Email:</td> 
                    <td><%=student.getEmail()%></td>
                </tr>
                <tr> 
                    <td>Password:</td> 
                    <td><input type="text" name="password" value=<%=student.getPassword()%>></td>
                </tr>
                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday"  value=<%=student.getBirthday()%>></td>
                </tr>
                <tr>
                    <td></td> 
                    <td><input type="submit" value="EditStudent" name="Edit"></td> 
                </tr>
            </table>
        </form>
                 <form><td>Click <input type="submit" value="cancel" name="cancel"/> to cancel your account.</td></form> 
    <hr>
    <p>Click <a href="main.jsp">here</a> to get to the main page.</p>
    <p>Click <a href="logout.jsp">here</a> to logout.</p>


    <%  } else if (tutor != null) {%>
    <form action="account.jsp" method="POST">
        <table>
            <tr> 
                <td>Full Name:</td> 
                <td><input type="text" name="name" value=<%=tutor.getName()%>></td> 
            </tr>
            <tr> 
                <td>Email:</td> 
                <td><%=tutor.getEmail()%></td>
            </tr>
            <tr> 
                <td>Password:</td> 
                <td><input type="text" name="password" value=<%=tutor.getPassword()%>></td>
            </tr>
            <tr> 
                <td>Date of Birth:</td> 
                <td><input type="text" name="birthday"  value=<%=tutor.getBirthday()%>></td>
            </tr>
            <tr>
                <td></td> 
                <td><input type="submit" value="EditTutor" name="Edit"></td> 
            </tr>
        </table>
    </form>
                 <form><td>Click <input type="submit" value="cancel" name="cancel"/> to cancel your account.</td></form> 
<hr>
<p>Click <a href="main.jsp">here</a> to get to the main page.</p>
<p>Click <a href="logout.jsp">here</a> to logout.</p>

<%  }
} else {

    if (button.equals("EditStudent")) {                                         // If 'edit' button is clicked, edit the fields and present them again. 
        student.setName(name);
        student.setPassword(password);
        student.setBirthday(birthday);
        //studentApp.updateXML(students, filePath);
%><h2>Details Updated!</h2>

<form action="account.jsp" method="POST">
    <table>
        <tr> 
            <td>Full Name:</td> 
            <td><input type="text" name="name" value=<%=student.getName()%>></td> 
        </tr>
        <tr> 
            <td>Email:</td> 
            <td><%=student.getEmail()%></td>
        </tr>
        <tr> 
            <td>Password:</td> 
            <td><input type="text" name="password" value=<%=student.getPassword()%>></td>
        </tr>

        <tr> 
            <td>Date of Birth:</td> 
            <td><input type="text" name="birthday"  value=<%=student.getBirthday()%>></td>
        </tr>
        <tr>
            <td></td> 
            <td><input type="submit" value="EditStudent" name="Edit"></td> 
        </tr>
    </table>

</form>
                 <form><td>Click <input type="submit" value="cancel" name="cancel"/> to cancel your account.</td></form> 
<hr>
<p>Click <a href="main.jsp">here</a> to get to the main page.</p>
<p>Click <a href="logout.jsp">here</a> to logout.</p>



<%  } else if (button.equals("EditTutor")) {
    tutor.setName(name);
    tutor.setPassword(password);
    tutor.setBirthday(birthday);
%><h2>Details Updated!</h2> 

<form action="account.jsp" method="POST">
    <table>

        <tr> 
            <td>Full Name:</td> 
            <td><input type="text" name="name" value=<%=tutor.getName()%>></td> 
        </tr>
        <tr> 
            <td>Email:</td> 
            <td><%=tutor.getEmail()%></td>
        </tr>

        <tr> 
            <td>Password:</td> 
            <td><input type="text" name="password" value=<%=tutor.getPassword()%>></td>
        </tr>

        <tr> 
            <td>Date of Birth:</td> 
            <td><input type="text" name="birthday"  value=<%=tutor.getBirthday()%>></td>
        </tr>
        <tr>
            <td></td> 
            <td><input type="submit" value="EditTutor" name="Edit"></td> 
        </tr>
    </table>

</form>
                 <form><td>Click <input type="submit" value="cancel" name="cancel"/> to cancel your account.</td></form> 
<hr>
<p>Click <a href="main.jsp">here</a> to get to the main page.</p>
<p>Click <a href="logout.jsp">here</a> to logout.</p>




<% }
    }
} else if (student != null && cancel.equals("cancel")) {                            // if current user is student, and cancel has been clicked, remove the student. 
    //Code for cancelling student account
    Students students = studentApp.getStudents();
    
    Bookings bookings = bookingApp.getBookingsByStudentEmail(student.getEmail());
    Tutors tutors = tutorApp.getTutors();

    if (bookings.getList() != null) {
        for (Booking b : bookings.getList()) {
            for (Tutor t : tutors.getList()) {
                if (b.getTutorName().equals(t.getName())) {
                    t.setStatus("available");
                }
            }
            b.setStatus("cancelled");
        }
    }
    students.removeUser(student);

%>
<h2>Your student account has been cancelled. Bye! </h2>
<p>Click <a href="index.jsp">here</a> to get to the home page.</p>

<% } else if (tutor != null && cancel.equals("cancel")) {                               // if current user is tutor, and cancel has been clicked, remove the tutor. 

    Tutors tutors = tutorApp.getTutors();
    
    Bookings bookings = bookingApp.getBookingsByTutorEmail(tutor.getName());
    if (bookings.getList() != null) {
        for (Booking b : bookings.getList()) {
            b.setStatus("cancelled");
        }
        tutor.setStatus("available");

    }
    tutors.removeUser(tutor);
%> 
    
<h2>Your tutor account has been cancelled. Bye! </h2>
<p>Click <a href="index.jsp">here</a> to get to the home page.</p>

<% }%>





</body>





</html>
