<%-- 
    Document   : main
    Created on : 15/09/2017, 1:00:11 PM
    Author     : Max
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Models.Student"%>
<%@page import="Models.Tutor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <% String filePath2 = application.getRealPath("WEB-INF/tutors.xml"); %>
        <jsp:useBean id="tutorApp" class="Applications.TutorApplication" scope="application">
            <jsp:setProperty name="tutorApp" property="filePath" value="<%=filePath2%>"/>
        </jsp:useBean>
        <% 
            Student student = (Student) session.getAttribute("student");
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            if(student != null || tutor != null){
                String name = request.getParameter("name");
                %>
                <h1>Main Page</h1>
                <% if(tutor != null){
                    %><p>Welcome, <%= tutor.getName() %>!</p>
                    <a href="booking.jsp">Bookings</a>
                <% }
                else{
                    %><p>Welcome, <%= student.getName() %>!</p>
                    <a href="booking.jsp">Bookings</a>
                    <form action="main.jsp" method="POST">
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
                        //String parameter = request.getParameter("subject");
                        String subject = request.getParameter("Subject");
                        //if(parameter != null){
                        if(subject != null){
                            %><p>Subject <%= subject %> is searched!</p><%
                            ArrayList<Tutor> tutors = tutorApp.getTutorBySubject(subject);
                            %>
                            <!--<form action="booking.jsp" method="GET">-->
                                <table>
                                    <thead>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Subject</th>
                                        <th>Status</th>
                                    </thead>
                                    <tbody>
                                    <% for(Tutor t : tutors){
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
                                    %>
                                    </tbody>
                                </table>
                            <!--</form>-->
                        <%}                        
                }%>
                <p>Click <a href="login.jsp">here</a> to return to the login page.</p>
            <% } else { %>
                <p>Incorrect login details. Click <a href="login.jsp">here</a> to return to the login page.</p>
            <% } %>
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
