<%-- 
    Document   : account
    Created on : Oct 2, 2017, 1:14:14 PM
    Author     : Mango
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Applications.BookingApplication"%>
<%@page import="Applications.StudentApplication"%>
<%@page import="Applications.TutorApplication"%>
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
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <title>TutorMe - Account </title>
    </head>

    <%
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String birthday = request.getParameter("birthday");
        String button = request.getParameter("Edit");
        String cancel = request.getParameter("cancel");
        
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
        if(session.getAttribute("bookingApp") == null){
            String bookingFilePath = application.getRealPath("WEB-INF/bookings.xml");
            %> <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="session">
                <jsp:setProperty name="bookingApp" property="filePath" value="<%=bookingFilePath%>"/>
            </jsp:useBean> <%
        } 
        TutorApplication tutorApp = (TutorApplication) session.getAttribute("tutorApp");
        StudentApplication studentApp = (StudentApplication) session.getAttribute("studentApp");
        BookingApplication bookingApp = (BookingApplication) session.getAttribute("bookingApp");
    %>
    <body>

        <c:import url="WEB-INF/tutors.xml" var="inputDocT" />
        <c:import url="WEB-INF/tutors2.xsl" var="stylesheetT" />
        <c:import url="WEB-INF/students.xml" var="inputDocS" />
        <c:import url="WEB-INF/students.xsl" var="stylesheetS" />

        <%
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");          
        %>
        <div id="headerSection">
            <h1>UTSTutor</h1>
            <div id="headerMenu">
                <a href="main.jsp">Main</a>
                <a href="index.jsp">Logout</a>
            </div>
        </div>
        <hr id="divider">
        <div id="bookingContentDiv">
            <h1>Your Account details</h1>
            <a href="main.jsp">Main</a>
            <h3>You may edit your details.</h3>

            <% if (cancel == null) {
                if (button == null) {
                    if (student != null) {                                                                          //if current session's user is a student, show their account details
                        //    Student student1 = studentApp.getStudentByName(student.getName()); %>
                        <x:transform xml="${inputDocS}" xslt="${stylesheetS}">     
                              <x:param name="stuEmail" value="${student.getEmail()}"/>
                        </x:transform>
                    <% } else if (tutor != null) { %>
                        <x:transform xml="${inputDocT}" xslt="${stylesheetT}">     
                             <x:param name="tutEmail" value="${tutor.getEmail()}"/>
                        </x:transform>
                    <% }
                } else {
                    if (button.equals("EditStudent")) {                                         // If 'edit' button is clicked, edit the fields and present them again. 
                        /*student.setName(name);
                        student.setPassword(password);
                        student.setBirthday(birthday);
                        studentApp.saveStudents();*/
                        studentApp.updateStudent(student.getEmail(), name, password, birthday);
                    %>
                    <h2>Details Updated!</h2>
                    <x:transform xml="${inputDocS}" xslt="${stylesheetS}">     
                          <x:param name="stuEmail" value="${student.getEmail()}"/>
                    </x:transform>
                    <% } 
                    else if (button.equals("EditTutor")) {
                        /*tutor.setName(name);
                        tutor.setPassword(password);
                        tutor.setBirthday(birthday);
                        tutorApp.saveTutors();*/
                        tutorApp.updateTutor(tutor.getEmail(), name, password, birthday);
                        %>
                        <h2>Details Updated!</h2> 
                        <x:transform xml="${inputDocT}" xslt="${stylesheetT}">     
                                <x:param name="tutEmail" value="${tutor.getEmail()}"/>
                        </x:transform>
                    <% }
                }
            } else if (student != null && cancel.equals("cancel")) {                            // if current user is student, and cancel has been clicked, remove the student. 
                //Code for cancelling student account
                Students students = studentApp.getStudents();
                students.removeUser(student);
                ArrayList<String> cancelledTutors = bookingApp.cancelBookingsByStudentEmail(student.getEmail());
                tutorApp.cancelTutorsByEmail(cancelledTutors);
                studentApp.saveStudents();
                /**Bookings bookings = bookingApp.getBookingsByStudent(student.getName());
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
                } 
                studentApp.saveStudents();
                tutorApp.saveTutors();
                bookingApp.saveBookings();*/
                
                    %>
                <h2>Your student account has been cancelled. Bye! </h2>
                <p>Click <a href="index.jsp">here</a> to get to the home page.</p>
            <% } else if (tutor != null && cancel.equals("cancel")) {                               // if current user is tutor, and cancel has been clicked, remove the tutor. 
                Tutors tutors = tutorApp.getTutors();
                tutors.removeUser(tutor);
                /*Bookings bookings = bookingApp.getBookingsByTutor(tutor.getName());
                if (bookings.getList() != null) {                                                       //set tutor's booking statuses as cancelled.
                    for (Booking b : bookings.getList()) {
                        b.setStatus("cancelled");
                    }
                }*/
                bookingApp.cancelBookingsByTutor(tutor);
                tutorApp.saveTutors();
                //bookingApp.saveBookings();
                %> 
                <h2>Your tutor account has been cancelled. Bye! </h2>
                <p>Click <a href="index.jsp">here</a> to get to the home page.</p>
            <% } %>
        </div>
    </body>
</html>
