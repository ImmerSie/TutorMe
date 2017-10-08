<%-- 
    Document   : createBooking
    Created on : 16/09/2017, 9:38:44 PM
    Author     : Max
--%>
<%@page import="Models.Tutors"%>
<%@page import="Models.Tutor"%>
<%@page import="Models.Student"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<html >
  <head>
    <title>Tutor Me!</title>
  </head>

  <body>
    <c:import url="WEB-INF/tutorSearch.xml" var="inputDoc" />

    <c:import url="WEB-INF/tutorSearch.xsl" var="stylesheet" />
    
        <%  String tutorsFilepath = application.getRealPath("WEB-INF/tutors.xml");
            String searchFilepath = application.getRealPath("WEB-INF/tutorSearch.xml");
        %>
        <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath" value="<%=tutorsFilepath%>"/>
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
                    
                    if(session.getAttribute("showSearch") != null){
                        Tutors searchedTutors = tutorApp.getAllSearchedTutors(searchFilepath);
                        String searchedBy = (String) session.getAttribute("searchBy");
                        String searchedVal = (String) session.getAttribute("searchVal");
                        if(session.getAttribute("showSearch").toString().equals("false")){ 
                            session.setAttribute("showSearch", "true");
                            //tutorApp.searchTutors(searchFilepath, "", "");
                            response.sendRedirect("main.jsp");
                        }
                        else{
                            %>
                                <x:transform xml="${inputDoc}" xslt="${stylesheet}"></x:transform>
                            <%
                        session.setAttribute("showSearch", null);
                        session.setAttribute("searchBy", searchBy);
                        session.setAttribute("searchVal", searchVal);
                        }
                    
                     } 
                    else if(searchBy != null && searchVal != null)
                    { 
                        tutorApp.searchTutors(searchFilepath, searchBy, searchVal);
                        session.setAttribute("showSearch", "false");
                        //session.setAttribute("searchBy", searchBy);
                        //session.setAttribute("searchVal", searchVal);
                        response.sendRedirect("main.jsp");
                    }
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
