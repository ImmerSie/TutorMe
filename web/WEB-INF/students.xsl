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
    <xsl:param name="stuEmail"/>


    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="students">
        <html>
            <head>
                <title>students.xsl</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="student">
        <xsl:variable name="thisEmail"> <xsl:value-of select="email"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="$stuEmail=$thisEmail">
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
                              <td><input type="text" name="password" value="{birthday}"/></td> 
                        </tr>
                        <tr>
                            <td></td> 
                            <td><input type="submit" value="EditStudent" name="Edit"/> </td> 
                        </tr>
                    </table>
                </form>
                 <form id="cancelBtn"><td>Click <input type="submit" value="cancel" name="cancel"/> to cancel your account.</td></form>   
            </xsl:when>  
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
