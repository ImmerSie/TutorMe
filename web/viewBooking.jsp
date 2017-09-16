<%-- 
    Document   : viewBooking
    Created on : 16/09/2017, 11:00:14 PM
    Author     : Max
--%>

<%@page import="Models.Booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Booking</title>
    </head>
    <body>
        <% String filePath = application.getRealPath("WEB-INF/bookings.xml");
            String filePath2 = application.getRealPath("WEB-INF/tutors.xml");
        %>
        <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
            <jsp:setProperty name="bookingApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath2" value="<%=filePath2%>"/>
        </jsp:useBean>
        <h1>View Booking</h1>
        <%
            String bookingString = request.getParameter("bookingID");
            int bookingID = Integer.parseInt(bookingString);
            Booking booking = bookingApp.getBookingByID(bookingID);
            if(booking != null){
                %>
                <p>Booking ID: <%= booking.getBookingID() %></p>
                <p>Tutor: <%= booking.getTutorName()%></p>
                <p>Tutor Email: <%= booking.getTutorEmail()%></p>
                <p>Subject: <%= booking.getSubject()%></p>
                <p>Student: <%= booking.getStudentName()%></p>
                <p>Student Email: <%= booking.getStudentEmail()%></p>
                <p>Status: <%= booking.getStatus()%></p>
            <% }
            %>
            <a href="booking.jsp">Return to Booking</a>
    </body>
</html>
