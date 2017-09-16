<%-- 
    Document   : booking
    Created on : 15/09/2017, 9:17:40 PM
    Author     : Max
--%>

<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@page import="Models.Booking"%>
<%@page import="Models.Bookings"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking</title>
    </head>
    <body>
        <h1>Booking Page</h1>
        <% String filePath = application.getRealPath("WEB-INF/bookings.xml");
            String filePath2 = application.getRealPath("WEB-INF/tutors.xml");
        %>
        <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
            <jsp:setProperty name="bookingApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath2" value="<%=filePath2%>"/>
        </jsp:useBean>
        <h2>My Bookings</h2>
        <%
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            String tutorid = request.getParameter("tutorid");
            if(tutorid != null){ %>
               <h1><%= tutorid %></h1>
            <%
                Tutor bookedTutor = tutorApp.getTutorFromID(tutorid);
                int bookingID = bookingApp.getNewBookingID();
                String tutName = tutorid;
                String tutEmail = bookedTutor.getEmail();
                String subject = bookedTutor.getSubject();
                String stuName = student.getName();
                String stuEmail = student.getEmail();
                String status = "active";
                Booking booking = new Booking(bookingID, tutName, tutEmail, subject, stuName, stuEmail, status);
                bookedTutor.setStatus("Unavailable");
                bookingApp.getBookings().addBooking(booking);
                bookingApp.saveBookings();
                tutorApp.saveTutors();
            }
         %>
        <a href="createBooking.jsp">Create Booking</a></br>
        <h2>My Bookings</h2>
        <table>
            <thead>
                <th>Tutor Name</th>
                <th>Tutor Email</th>
                <th>Subject</th>
                <th>Student Name</th>
                <th>Student Email</th>
                <th>Status</th>
            </thead>
            <tbody>
            <%  
                Bookings bookings;
                if(student != null){
                    bookings = bookingApp.getBookingsByStudent(student.getName());
                }
                else{
                    bookings = bookingApp.getBookingsByTutor(tutor.getName());
                }
                //Bookings bookings = bookingApp.getBookings();
                for(Booking b : bookings.getList()){
                    %> <form action="viewBooking.jsp" method="GET"><tr>
                    <td><%= b.getTutorName() %></td>
                    <td><%= b.getTutorEmail() %></td>
                    <td><%= b.getSubject() %></td>
                    <td><%= b.getStudentName() %></td>
                    <td><%= b.getStudentEmail() %></td>
                    <td><%= b.getStatus() %></td>
                    <td><input type="submit" value="View" name="View"></td>
                    <td><input type="hidden" value="<%= b.getBookingID() %>" id="bookingID" name="bookingID"></td>
                </tr></form>
            <% }
            %>
            </tbody>
        </table>
            
        <h2>All Bookings</h2>
        <table>
            <thead>
                <th>Tutor Name</th>
                <th>Tutor Email</th>
                <th>Subject</th>
                <th>Student Name</th>
                <th>Student Email</th>
                <th>Status</th>
            </thead>
            <tbody>
            <%  
                Bookings allBookings = bookingApp.getBookings();
                for(Booking b : allBookings.getList()){
            %> <form action="viewBooking.jsp" method="GET"><tr>
                    <td><%= b.getTutorName() %></td>
                    <td><%= b.getTutorEmail() %></td>
                    <td><%= b.getSubject() %></td>
                    <td><%= b.getStudentName() %></td>
                    <td><%= b.getStudentEmail() %></td>
                    <td><%= b.getStatus() %></td>
                    <td><input type="submit" value="View" name="View"></td>
                    <td><input type="hidden" value="<%= b.getBookingID() %>" id="bookingID" name="bookingID"></td>
                </tr></form>
            <% }
            %>
            </tbody>
        </table>
        <a href="main.jsp">Return to Main</a>
    </body>
</html>
