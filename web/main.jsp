<%-- 
    Document   : createBooking
    Created on : 16/09/2017, 9:38:44 PM
    Author     : Max
--%>
<%@page import="Applications.TutorApplication"%>
<%@page import="Models.Tutors"%>
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
        <c:import url="WEB-INF/tutorSearch.xml" var="inputDoc" />

        <c:import url="WEB-INF/tutorSearch.xsl" var="stylesheet" />

            <%  
            String searchFilepath = application.getRealPath("WEB-INF/tutorSearch.xml");
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
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            if(student != null || tutor != null)
            {
                if(session.getAttribute("showSearch") != null){
                    Tutors searchedTutors = tutorApp.getAllSearchedTutors(searchFilepath);
                    if(searchedTutors.getList().size() < 1){
                        response.sendRedirect("errorPage.jsp");
                        return;
                    }
                }
                String name = request.getParameter("name");
                %>
                <div id="headerSection">
                    <h1>UTSTutor</h1>
                    <div id="headerMenu">
                        <a href="account.jsp">Account</a>
                        <a href="index.jsp">Logout</a>
                    </div>
                </div>
                <hr id="divider">
                <div id="mainContentDiv">
                    <h1>Main Page</h1>
                    <% if(tutor != null){
                        %><p>Welcome, <%= tutor.getName() %>!</p>
                        <a href="booking.jsp">Bookings</a>
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
                            String searchedBy = (String) session.getAttribute("searchBy");
                            String searchedVal = (String) session.getAttribute("searchVal");
                            if(session.getAttribute("showSearch").toString().equals("false")){ 
                                session.setAttribute("showSearch", "true");
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
                            response.sendRedirect("main.jsp");
                        }
                    }
                }
                else {
                    response.sendRedirect("login.jsp");
                 } %>
                <!--<p>Click <a href="account.jsp">here</a> to access your account details.</p>-->
            </div>
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
