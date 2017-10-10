<%@page import="Models.Booking"%>
<%@page import="Applications.BookingApplication"%>
<%@page import="Applications.StudentApplication"%>
<%@page import="Applications.TutorApplication"%>
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
        <c:import url="WEB-INF/viewBooking.xsl" var="viewStylesheet" />
        <% 
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
            //if(student == null && tutor == null){
                
                String tutorid = request.getParameter("tutorid");
                if(tutorid != null){ %>
                    <h1><%= tutorid %></h1>
                    <%
                    String confirmation = request.getParameter("confirm");
                    if(confirmation != null){ %>
                        <form action="booking.jsp" method="POST">
                            <td><input type="hidden" value="<%= tutorid %>" id="tutorid" name="tutorid"></td>
                            <input type="submit" value="Confirm Booking" name="confirmBtn">
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

                if(request.getParameter("bookingID") != null){
                
                    Booking booking = bookingApp.getBookingByID(Integer.parseInt(request.getParameter("bookingID")));
                    if(request.getParameter("cancelled") != null){
                        booking.setStatus("cancelled");
                        Tutor bookTutor = tutorApp.getTutorFromEmail(booking.getTutorEmail());
                        bookTutor.setStatus("available");
                        tutorApp.saveTutors();
                        bookingApp.saveBookings();
                        %><h3>Booking has been canceled!</h3> <%
                    }
                    else if(request.getParameter("completed") != null){
                        booking.setStatus("completed");
                        Tutor bookTutor = tutorApp.getTutorFromEmail(booking.getTutorEmail());
                        bookTutor.setStatus("available");
                        tutorApp.saveTutors();
                        bookingApp.saveBookings();
                        %><h3>Booking has been Completed!</h3> <%
                    }
                }
     
                String view = (String) request.getParameter("view");
                    if(view == null || view.equals("all")){
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
                    }
                    else{
                        String isTutor = "false";
                        if(tutor != null){
                            isTutor = "true";
                        } %>
                        <x:transform xml="${inputDoc}" xslt="${viewStylesheet}">
                            <x:param name="isTutor"  value="<%= isTutor %>" />
                            <x:param name="viewID"  value="<%= view %>" />
                        </x:transform>
                    <% }
            //}
            /*else {
                response.sendRedirect("login.jsp");
            }*/%>
        </div>
  </body>
</html>
