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
    <xsl:param name="tutEmail"/>


    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="tutors">
        <html>
            <head>
                <title>tutors.xsl</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="tutor">
        <xsl:variable name="thisEmail"> <xsl:value-of select="email"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="$tutEmail=$thisEmail">
                 <form action="account.jsp" method="POST">
                    <table>
                        <tr> 
                            <td>Full Name:</td>
                            <td><input type="text" name="name" value="{name}"/></td> 
                        </tr>
                        <tr> 
                            <td>Email:</td> 
                            <td><xsl:value-of select="email"/></td>
                        </tr>

                        <tr> 
                            <td>Password:</td> 
                            <td><input type="text" name="password" value="{password}"/></td> 
                        </tr>

                        <tr> 
                            <td>Date of Birth:</td> 
                            <td><input type="text" name="birthday" value="{birthday}"/></td> 
                        </tr>
                        <tr>            
                            <td></td> 
                            <td><input type="submit" value="EditTutor" name="Edit"/> </td> 
                        </tr>
                    </table>
                </form>
                 <form><td>Click <input type="submit" value="cancel" name="cancel"/> to cancel your account.</td></form> 
                <hr/>
                    <p>Click <a href="main.jsp">here</a> to get to the main page.</p>
                    <p>Click <a href="logout.jsp">here</a> to logout.</p>   
            </xsl:when>  
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
