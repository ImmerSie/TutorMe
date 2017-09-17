<%-- 
    Document   : createBooking
    Created on : 16/09/2017, 9:38:44 PM
    Author     : Max
--%>

<%@page import="Models.Tutor"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Booking</title>
    </head>
    <body>
        <h1>Create Booking</h1>
        <% String filePath = application.getRealPath("WEB-INF/bookings.xml");
           String filePath2 = application.getRealPath("WEB-INF/tutors.xml"); %>
        <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
            <jsp:setProperty name="bookingApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath" value="<%=filePath2%>"/>
        </jsp:useBean>
        
        <form action="createBooking.jsp" method="POST">
            <select name="Subject" id="subjectList">
                <option value="WSD">WSD</option>
                <option value="USP">USP</option>
                <option value="SEP">SEP</option>
                <option value="AppProg">AppProg</option>
                <option value="MobileApp">MobileApp</option>

            </select>
            <input type="submit" value="Search" name="Search">
        </form>
        <%
        String subject = request.getParameter("Subject");
        if(subject != null){
            %><p>Subject <%= subject %> is searched!</p>
            <%  ArrayList<Tutor> tutors = tutorApp.getTutorBySubject(subject); 
            if(tutors.size() <= 0){
                %><p>There are no tutors in this subject.</p>
            <% } else { %>
                <table>
                    <thead>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Status</th>
                    </thead>
                    <tbody>
                    <% for(Tutor t : tutors){
                        if(!t.getStatus().equals("Unavailable")){
                        %> <tr>
                                <form action="booking.jsp" method="GET">
                                    <td><%= t.getName() %></td>
                                    <td><%= t.getEmail() %></td>
                                    <td><%= t.getSubject() %></td>
                                    <td><%= t.getStatus() %></td>
                                    <td><input type="submit" value="Book" name="Book"></td>
                                    <input type="hidden" name="tutorid" id="tutorid" value="<%= t.getName() %>">
                                </form>
                            </tr>
                        <% }
                    } 
                } %>
                </tbody>
            </table>
        <% } %>
        <a href="booking.jsp">Cancel</a>
    </body>
</html>

                