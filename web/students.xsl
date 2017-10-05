<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : account.xsl
    Created on : October 3, 2017, 10:03 PM
    Author     : Mango
    Description:
        Purpose of transformation follows.
                    <x:param name="stuEmail"  value="<%= stuEmail%>" />

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
        <xsl:param name="stuName"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
  <xsl:template match="students">
        <html>
            <head>
                <title>students.xsl</title>
            </head>
            <body>
     <xsl:choose>
      <xsl:when test='>

            <form action="account.jsp" method="POST">
            <table>

                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name" value=<%=student.getName()%>></td> 
                </tr>
                <tr> 
                    <td>Email:</td> 
                    <td><%=student.getEmail()%></td>
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="text" name="password" value=<%=student.getPassword()%>></td>
                </tr>

                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday"  value=<%=student.getBirthday()%>></td>
                </tr>
                <tr>
                    <td></td> 
                    <td><input type="submit" value="EditStudent" name="Edit"></td> 
                </tr>
            </table>
        </form>
        <p>Click <form><input type="submit" value="cancel" name="cancel"></form> to cancel your account.</p>
        <hr>
        <p>Click <a href="main.jsp">here</a> to get to the main page.</p>
        <p>Click <a href="logout.jsp">here</a> to logout.</p>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="student">
        <tr>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="email"/></td>
            <td><xsl:value-of select="password"/></td>
            <td><xsl:value-of select="birthday"/></td>

        </tr>
    </xsl:template>

</xsl:stylesheet>
