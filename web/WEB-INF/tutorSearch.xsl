<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : tutors.xsl
    Created on : 4 October 2017, 12:52 AM
    Author     : Max
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="tutors">
        <html>
            <head>
                <title>tutors.xsl</title>
            </head>
            <body>
                <table>
                    <thead>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Status</th>
                    </thead>
                    <tbody>
                        <xsl:apply-templates/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tutor">
        <form action="booking.jsp" method="GET">
        <tr>
            <xsl:variable name="tutName"><xsl:value-of select="name"/></xsl:variable>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="email"/></td>
            <td><xsl:value-of select="subject"/></td>
            <td><xsl:value-of select="status"/></td>
            <xsl:variable name="tutStatus">
                <xsl:value-of select="status"/>
            </xsl:variable>
            <xsl:if test="$tutStatus='available'">
                <td><input type="submit" value="Book" name="Book"></input></td>
                <td><input type="hidden" value="{$tutName}" id="tutorid" name="tutorid"></input></td>
                <td><input type="hidden" value="true" name="confirm"></input></td>
            </xsl:if>
        </tr></form>
    </xsl:template>

</xsl:stylesheet>
