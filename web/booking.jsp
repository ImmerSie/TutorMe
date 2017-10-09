<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<html >
    <head>
      <link href="template.css" rel="stylesheet" type="text/css"/>
      <title>Tutor Me!</title>
    </head>

    <body>
        <c:import url="WEB-INF/bookings.xml" var="inputDoc" />
        <c:import url="WEB-INF/bookings.xsl" var="stylesheet" />

        <% 
            String bookingsFilePath = application.getRealPath("WEB-INF/bookings.xml");
            String tutorFilePath = application.getRealPath("WEB-INF/tutors.xml");
        %>
        <jsp:useBean id="bookingApp" class="Applications.BookingApplication" scope="application">
            <jsp:setProperty name="bookingApp" property="filePath" value="<%=bookingsFilePath%>"/>
        </jsp:useBean>
        <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath" value="<%=tutorFilePath%>"/>
        </jsp:useBean>
        <div id="headerSection">
            <h1>UTSTutor</h1>
            <div id="headerMenu">
                <a href="main.jsp">Main</a>
                <a href="index.jsp">Logout</a>
            </div>
        </div>
        <hr id="divider">
        <div id="bookingContentDiv">
            <h1>Booking Page</h1>
            <table id="breadcrumbsTbl">
                <tr>
                    <td><a href="main.jsp">Main</a></td>
                </tr>
            </div>
            <%
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            String tutorid = request.getParameter("tutorid");
            if(tutorid != null){ %>
                <h1><%= tutorid %></h1>
                <%
                String confirmation = request.getParameter("confirm");
                if(confirmation != null){ %>
                    <form action="booking.jsp" method="POST">
                        <td><input type="hidden" value="<%= tutorid %>" id="tutorid" name="tutorid"></input></td>
                        <input type="submit" value="Confirm Booking" name="confirmBtn"></input> 
                    </form>
                <% }
                else{
                    Tutor bookedTutor = tutorApp.getTutorFromID(tutorid);
                    if(bookedTutor.getStatus().toLowerCase().equals("available")){
                        bookingApp.createBooking(bookedTutor, student);
                        tutorApp.saveTutors();
                        response.sendRedirect("/TutorMe/booking.jsp");
                    }
                }
            }
            if(student != null){ %>
                 <x:transform xml="${inputDoc}" xslt="${stylesheet}">
                    <x:param name="studentEmail"  value="${student.getEmail()}" />
                </x:transform>
            <% } 
            else if(tutor != null){ %>
                 <x:transform xml="${inputDoc}" xslt="${stylesheet}">
                    <x:param name="tutorEmail"  value="${tutor.getEmail()}" />
                </x:transform>
            <% } 
            else {
                response.sendRedirect("login.jsp");
            }%>
            
            <h2>All Bookings</h2>
            <x:transform xml="${inputDoc}" xslt="${stylesheet}">
                <x:param name="studentEmail"  value="getAll" />
            </x:transform>
        </div>
  </body>
</html>
