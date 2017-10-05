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
    
        <% String filePath2 = application.getRealPath("WEB-INF/tutors.xml"); %>
        <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath" value="<%=filePath2%>"/>
        </jsp:useBean>
        <% 
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            if(student != null || tutor != null)
            {
                String name = request.getParameter("name");
                %>
                <h1>Main Page</h1>
                <% if(tutor != null){
                    %><p>Welcome, <%= tutor.getName() %>!</p>
                    <a href="oldBookings.jsp">Bookings</a>
                <% } else {
                    %><p>Welcome, <%= student.getName() %>!</p>
                    <a href="booking.jsp">Bookings</a>
                    <form action="main.jsp" method="POST">
                        <select name="searchBy" id="searchList">
                            <option value="searchStatus">Status</option>
                            <option value="searchSubject">Subject</option>
                            <option value="searchName">Name</option> 
                        </select>
                        <input type="text" name="searchVal">
                        <input type="submit" value="Search" name="Search">
                    </form>
                    <%
                    String searchVal = request.getParameter("searchVal");
                    String searchBy = request.getParameter("searchBy");
                    if(searchBy != null && searchVal != null)
                    { %>
                        <x:transform xml="${inputDoc}" xslt="${stylesheet}">
                            <x:param name="searchVal"  value="<%= searchVal %>" />
                            <x:param name="searchBy"  value="<%= searchBy %>" />
                        </x:transform>
                    <%}  
                }
            }
            else { %>
            <hr>
                <p>Incorrect login details. Click <a href="login.jsp">here</a> to return to the login page.</p>
            <% } %>
            <hr>
            <p>Click <a href="account.jsp">here</a> to access your account details.</p>
            <p>Click <a href="logout.jsp">here</a> to logout.</p>
    </body>
</html>

<script type="text/javascript">
    function searchSubject(){
        var e = document.getElementById("subjectList");
        var subject = e.options[e.selectedIndex].text;
        var currentURL = window.location.href;
        if(currentURL.indexOf('?') > 0){
            currentURL = currentURL.substring(0, currentURL.indexOf('?'));
        }
        window.location = currentURL + "?subject=" + subject;
        //window.location = "../TutorMe/main.jsp?subject="+subject;
    }
</script>
