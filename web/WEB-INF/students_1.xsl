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
                    <table>
                        <tr> 
                            <td>Full Name:</td>
                            <td><xsl:value-of select="name"/></td> 
                        </tr>
                        <tr> 
                            <td>Email:</td> 
                            <td><xsl:value-of select="email"/></td>
                        </tr>

                        <tr> 
                            <td>Password:</td> 
                            <td><xsl:value-of select="password"/></td> 
                        </tr>

                        <tr> 
                            <td>Date of Birth:</td> 
                            <td><xsl:value-of select="birthday"/></td> 
                        </tr>
              
                    </table>   
    </xsl:template>   
</xsl:stylesheet>
