<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<html >
  <head>
    <title>Using a Named Template with Global Parameters</title>
  </head>

  <body>
    <c:import url="http://localhost:8080/TutorMe/bookings.xml" var="inputDoc" />

    <c:import url="http://localhost:8080/TutorMe/bookings.xsl" var="stylesheet" />
    
    <h1>Booking Page</h1>
    
    <% 
        String filePath = application.getRealPath("bookings.xml");
        String filePath2 = application.getRealPath("WEB-INF/tutors.xml");
    %>
    <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
        <jsp:setProperty name="bookingApp" property="filePath" value="<%=filePath%>"/>
    </jsp:useBean>
    <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
        <jsp:setProperty name="tutorApp" property="filePath2" value="<%=filePath2%>"/>
    </jsp:useBean>
    <%
        Student student = (Student) session.getAttribute("student");
        Tutor tutor = (Tutor) session.getAttribute("tutor");
        String tutorid = request.getParameter("tutorid");
        if(tutorid != null){ %>
           <h1><%= tutorid %></h1>
        <%
            Tutor bookedTutor = tutorApp.getTutorFromID(tutorid);

            bookingApp.createBooking(bookedTutor, student);
            tutorApp.saveTutors();
        }
     %>
    <% if(student != null){
        %><a href="createBooking.jsp">Create Booking</a></br><%          
    } %>

    <x:transform xml="${inputDoc}" xslt="${stylesheet}">
    </x:transform>
    
    <a href="main.jsp">Return to Main</a>
  </body>
</html>
