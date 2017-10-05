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

    <% String filePath = application.getRealPath("WEB-INF/students.xml");
        String filePath2 = application.getRealPath("WEB-INF/tutors.xml");
       String filePath3 = application.getRealPath("WEB-INF/bookings.xml");

    %>
    <jsp:useBean id="studentApp" class="Applications.StudentApplication" scope="application">
        <jsp:setProperty name="studentApp" property="filePath" value="<%=filePath%>"/>
    </jsp:useBean>
    <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
        <jsp:setProperty name="tutorApp" property="filePath2" value="<%=filePath2%>"/>
    </jsp:useBean>
    <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
            <jsp:setProperty name="bookingApp" property="filePath3" value="<%=filePath3%>"/>
        </jsp:useBean>




    <body>
        
    <c:import url="http://localhost:8080/TutorMe/students.xml" var="inputDoc1" />
    <c:import url="http://localhost:8080/TutorMe/students.xsl" var="stylesheet1" />
    <c:import url="http://localhost:8080/TutorMe/tutors.xml" var="inputDoc2" />
    <c:import url="http://localhost:8080/TutorMe/tutors.xsl" var="stylesheet2" />
    
    
    
    
        <%  Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");

        %>
        <h1>Your Account details</h1>
        <h3>You may edit your details.</h3>

        <% if (cancel == null) {
                if (button == null) {
                    if (student != null) {                                                                          //if current session's user is a student, show their account details
                        //    Student student1 = studentApp.getStudentByName(student.getName()); %>


            <x:transform xml="${inputDoc1}" xslt="${stylesheet1}"> </x:transform>
        <p>Click <form><input type="submit" value="cancel" name="cancel"></form> to cancel your account.</p>



    <%  } else if (tutor != null) {%>
    <form action="account.jsp" method="POST">
        <x:transform xml="${inputDoc2}" xslt="${stylesheet2}">
            </x:transform>

    </form>

    <%  }
    } else {

        if (button.equals("EditStudent")) {                                         // If 'edit' button is clicked, edit the fields and present them again. 
            student.setName(name);
            student.setPassword(password);
            student.setBirthday(birthday);
            //studentApp.updateXML(students, filePath);
%><h2>Details Updated!</h2>

    <x:transform xml="${inputDoc1}" xslt="${stylesheet1}"></x:transform>
    
    
    <p>Click <form><input type="submit" value="cancel" name="cancel"></form> to cancel your account.</p>




<%        } else if (button.equals("EditTutor")) {
    tutor.setName(name);
    tutor.setPassword(password);
    tutor.setBirthday(birthday);
%><h2>Details Updated!</h2> 

<x:transform xml="${inputDoc2}" xslt="${stylesheet2}">
            </x:transform>



<% }
        }
    } else if (student != null && cancel.equals("cancel")) {                            // if current user is student, and cancel has been clicked, remove the student. 
        //Code for cancelling student account
        Students students = studentApp.getStudents();
        students.removeUser(student); 
        Bookings bookings = bookingApp.getBookingsByTutor(tutor.getName());
        for(Booking b : bookings.getList()){
            b.setStatus("cancelled");
        }%>    
        <h2>Your account has been cancelled. Bye! </h2>
   <% }else if (tutor !=null && cancel.equals("cancel")){                               // if current user is tutor, and cancel has been clicked, remove the tutor. 
            
        Tutors tutors = tutorApp.getTutors();
        tutors.removeUser(tutor); 
        Bookings bookings = bookingApp.getBookingsByTutor(tutor.getName());
        for(Booking b : bookings.getList()){
            b.setStatus("cancelled");
        }%> 
        <h2>Your tutor account has been cancelled. Bye! </h2>
    <% }%>



<hr>

<p>Click <a href="main.jsp">here</a> to get to the main page.</p>
<p>Click <a href="logout.jsp">here</a> to logout.</p>
</body>





</html>
