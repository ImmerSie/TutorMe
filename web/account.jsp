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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

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

    <% 
        String studentFilePath = application.getRealPath("WEB-INF/students.xml");
        String tutorFilePath = application.getRealPath("WEB-INF/tutors.xml");
        String bookingFilePath = application.getRealPath("WEB-INF/bookings.xml");

    %>
    <jsp:useBean id="studentApp" class="Applications.StudentApplication" scope="application">
        <jsp:setProperty name="studentApp" property="filePath" value="<%=studentFilePath%>"/>
    </jsp:useBean>
    <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
        <jsp:setProperty name="tutorApp" property="filePath" value="<%=tutorFilePath%>"/>
    </jsp:useBean>
    <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
        <jsp:setProperty name="bookingApp" property="filePath" value="<%=bookingFilePath%>"/>
    </jsp:useBean>
    <body>
        <c:import url="WEB-INF/tutors.xml" var="inputDocT" />
        <c:import url="WEB-INF/tutors.xsl" var="stylesheetT" />
        <c:import url="WEB-INF/students.xml" var="inputDocS" />
        <c:import url="WEB-INF/students.xsl" var="stylesheetS" />

        <%
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            if(studentCheck == null && tutorCheck == null){
                response.sendRedirect("login.jsp");
            }
        %>
        <h1>Your Account details</h1>
        <h3>You may edit your details.</h3>

        <% if (cancel == null) {
                if (button == null) {
                    if (student != null) {                                                                          //if current session's user is a student, show their account details
                        //    Student student1 = studentApp.getStudentByName(student.getName()); %>
                    <x:transform xml="${inputDocS}" xslt="${stylesheetS}">                                                      <!-- Import XML and use XSL stylesheet to transform -->
                        <x:param name="stuEmail" value="<%= student.getEmail()%>"/>
                        <x:param name="stuName" value="<%= student.getName()%>"/>
                        <x:param name="stuPassword" value="<%= student.getPassword()%>"/>
                        <x:param name="stuBirthday" value="<%= student.getBirthday()%>"/>
                    </x:transform>
                    <% } else if (tutor != null) { %>
                        <x:transform xml="${inputDocT}" xslt="${stylesheetT}">                                                      <!-- Import XML and use XSL stylesheet to transform -->
                            <x:param name="tutEmail" value="<%= tutor.getEmail()%>"/>
                        </x:transform>
                    <%  }
                } else {
                    if (button.equals("EditStudent")) {                                         // If 'edit' button is clicked, edit the fields and present them again. 
                        student.setName(name);
                        student.setPassword(password);
                        student.setBirthday(birthday);
                        //studentApp.updateXML(students, filePath);
                        %><h2>Details Updated!</h2>

                        <x:transform xml="${inputDocS}" xslt="${stylesheetS}">                                                      <!-- Import XML and use XSL stylesheet to transform -->
                            <x:param name="stuEmail" value="<%= student.getEmail()%>"/>
                        </x:transform>
                    <% } 
                    else if (button.equals("EditTutor")) {
                        tutor.setName(name);
                        tutor.setPassword(password);
                        tutor.setBirthday(birthday);
                        %>
                        <h2>Details Updated!</h2> 

                        <x:transform xml="${inputDocT}" xslt="${stylesheetT}">                                                      <!-- Import XML and use XSL stylesheet to transform -->
                            <x:param name="tutEmail" value="<%= tutor.getEmail()%>"/>
                        </x:transform>
                    <% }
                }
            } 
        else if (student != null && cancel.equals("cancel")) {                            // if current user is student, and cancel has been clicked, remove the student. 
                //Code for cancelling student account
                Students students = studentApp.getStudents();
                students.removeUser(student);
                Bookings bookings = bookingApp.getBookingsByStudent(student.getName());
                Tutors tutors = tutorApp.getTutors();

                if (bookings.getList() != null) {                                               //set student's bookings as cancelled, and that booking's tutor's status as available. 
                    for (Booking b : bookings.getList()) {
                        for (Tutor t : tutors.getList()) {
                            if (b.getTutorName().equals(t.getName())) {
                                t.setStatus("available");
                            }
                        }
                        b.setStatus("cancelled");
                    }
                } %>
                <h2>Your student account has been cancelled.</h2>
                <p>Click <a href="index.jsp">here</a> to get to the home page.</p>
            <% } 
            else if (tutor != null && cancel.equals("cancel")) {                               // if current user is tutor, and cancel has been clicked, remove the tutor. 
                Tutors tutors = tutorApp.getTutors();
                tutors.removeUser(tutor);
                Bookings bookings = bookingApp.getBookingsByTutor(tutor.getName());
                if (bookings.getList() != null) {                                                       //set tutor's booking statuses as cancelled.
                    for (Booking b : bookings.getList()) {
                        b.setStatus("cancelled");
                    }
                } %> 
                <h2>Your tutor account has been cancelled. Bye! </h2>
                <p>Click <a href="index.jsp">here</a> to get to the home page.</p>
            <% } %>
    </body>
</html>

<form action="account.jsp">
    <input type="text" label="Email" name="email" error="Email address invalid"/>
    <input type="password" label="Password" name="password" error="Password invalid"/>
</form>