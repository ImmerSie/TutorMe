<%-- 
    Document   : createBooking
    Created on : 16/09/2017, 9:38:44 PM
    Author     : Max
--%>
<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<html >
  <head>
    <title>Tutor Me!</title>
  </head>

  <body>
    <c:import url="WEB-INF/tutors.xml" var="inputDoc" />

    <c:import url="WEB-INF/tutors.xsl" var="stylesheet" />
    
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
            <x:transform xml="${inputDoc}" xslt="${stylesheet}">
            </x:transform>
        <% } %>
        <a href="booking.jsp">Cancel</a>
    </body>
</html>

                