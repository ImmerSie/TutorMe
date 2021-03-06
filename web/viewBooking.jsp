<%-- 
    Document   : viewBooking
    Created on : 16/09/2017, 11:00:14 PM
    Author     : Max
--%>

<%@page import="Applications.BookingApplication"%>
<%@page import="Applications.StudentApplication"%>
<%@page import="Applications.TutorApplication"%>
<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@page import="Models.Booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <title>View Booking</title>
    </head>
    <body>
        <% if(session.getAttribute("studentApp") == null){
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
        <div id="headerSection">
            <h1>UTSTutor</h1>
            <div id="headerMenu">
                <a href="main.jsp">Main</a>
                <a href="index.jsp">Logout</a>
            </div>
        </div>
        <hr id="divider">
        <div id="viewBookDiv">
            <h1>View Booking</h1>
            <table id="breadcrumbsTbl">
                <tr>
                    <td><a href="main.jsp">Main</a></td>
                    <td><p> > </p></td>
                    <td><a href="booking.jsp">Bookings</a></td>
                </tr>
            </table>
            <%
            Student studentCheck = (Student) session.getAttribute("student");
            Tutor tutorCheck = (Tutor) session.getAttribute("tutor");
            if(studentCheck == null && tutorCheck == null){
                response.sendRedirect("login.jsp");
            }
            else{
                String bookingString = request.getParameter("bookingID");
                String cancelled = request.getParameter("cancelled");
                String completed = request.getParameter("completed");
                int bookingID = Integer.parseInt(bookingString);
                Booking booking = bookingApp.getBookingByID(bookingID);
                if(booking != null){
                    if(cancelled != null){
                        booking.setStatus("cancelled");
                        Tutor tutor = tutorApp.getTutorFromID(booking.getTutorName());
                        tutor.setStatus("available");
                        tutorApp.saveTutors();
                        bookingApp.saveBookings();
                        %><h3>Booking has been canceled!</h3> <%
                    }
                    else if(completed != null){
                        booking.setStatus("completed");
                        Tutor tutor = tutorApp.getTutorFromID(booking.getTutorName());
                        tutor.setStatus("available");
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
                            <input type="hidden" value="cancelled" id="canceled" name="cancelled">
                        </form>
                        <% if((Tutor) session.getAttribute("tutor") != null)
                        { %>
                            <form action="viewBooking.jsp" method="POST">
                                <input type="submit" value="Complete" name="Completed">
                                <input type="hidden" value="<%= booking.getBookingID() %>" id="bookingID" name="bookingID">
                                <input type="hidden" value="completed" id="completed" name="completed">
                            </form>
                        <% }     
                    }                
                }
            } %>
        </div>
    </body>
</html>
