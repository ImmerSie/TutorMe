<%-- 
    Document   : viewBooking
    Created on : 16/09/2017, 11:00:14 PM
    Author     : Max
--%>

<%@page import="Models.Tutor"%>
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
            String cancelled = request.getParameter("canceled");
            String completed = request.getParameter("completed");
            int bookingID = Integer.parseInt(bookingString);
            Booking booking = bookingApp.getBookingByID(bookingID);
            if(booking != null){
                if(cancelled != null){
                    booking.setStatus("canceled");
                    Tutor tutor = tutorApp.getTutorFromID(booking.getTutorName());
                    tutor.setStatus("Available");
                    tutorApp.saveTutors();
                    bookingApp.saveBookings();
                    %><h3>Booking has been canceled!</h3> <%
                }
                else if(completed != null){
                    booking.setStatus("completed");
                    Tutor tutor = tutorApp.getTutorFromID(booking.getTutorName());
                    tutor.setStatus("Available");
                    tutorApp.saveTutors();
                    bookingApp.saveBookings();
                    %><h3>Booking has been Completed!</h3> <%
                } 
                %>
                <p>Booking ID: <%= booking.getBookingID() %></p>
                <p>Tutor: <%= booking.getTutorName()%></p>
                <p>Tutor Email: <%= booking.getTutorEmail()%></p>
                <p>Subject: <%= booking.getSubject()%></p>
                <p>Student: <%= booking.getStudentName()%></p>
                <p>Student Email: <%= booking.getStudentEmail()%></p>
                <p>Status: <%= booking.getStatus()%></p>
                <% if(booking.getStatus().equals("active")){ %>
                    <form action="viewBooking.jsp" method="POST">
                        <input type="submit" value="Cancel" name="Cancel">
                        <input type="hidden" value="<%= booking.getBookingID() %>" id="bookingID" name="bookingID">
                        <input type="hidden" value="canceled" id="canceled" name="canceled">
                    </form>
                    <% if((Tutor) session.getAttribute("tutor") != null)
                    { %>
                        <form action="viewBooking.jsp" method="POST">
                            <input type="submit" value="Completed" name="Completed">
                            <input type="hidden" value="<%= booking.getBookingID() %>" id="bookingID" name="bookingID">
                            <input type="hidden" value="completed" id="completed" name="completed">
                        </form>
                    <% }
                }                
            } %>
            <a href="booking.jsp">Return to Booking</a>
    </body>
</html>