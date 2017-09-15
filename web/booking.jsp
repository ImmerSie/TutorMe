<%-- 
    Document   : booking
    Created on : 15/09/2017, 9:17:40 PM
    Author     : Max
--%>

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
        <% String filePath = application.getRealPath("WEB-INF/bookings.xml"); %>
        <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
            <jsp:setProperty name="bookingApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
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
            <% Bookings bookings = bookingApp.getBookings();
                for(Booking b : bookings.getList()){
            %> <tr>
                    <td><%= b.getTutorName() %></td>
                    <td><%= b.getTutorEmail() %></td>
                    <td><%= b.getSubject() %></td>
                    <td><%= b.getStudentName() %></td>
                    <td><%= b.getSudentEmail() %></td>
                    <td><%= b.getStatus() %></td>
                </tr>
            <% }
            %>
            </tbody>
        </table>
    </body>
</html>
