<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : bookings.xsl
    Created on : 3 October 2017, 6:22 PM
    Author     : Max
    Description:
        Purpose of transformation follows.
        To display a table of bookings, filtered by either the student or the tutor
        who made them
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    
    <!-- Parameters to filter using the user data -->
    <xsl:param name="studentEmail"/>
    <xsl:param name="tutorEmail"/>
    
    <!-- root of xml document -->
    <xsl:template match="bookings">
        <html>
            <head>
                <title>bookings.xsl</title>
            </head>
            <body>
                <table>
                <thead>
                    <tr>
                        <th>Booking Id</th>
                        <th>Tutor Name</th>
                        <th>Tutor Email</th>
                        <th>Subject</th>
                        <th>Student Name</th>
                        <th>Student Email</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates/>
                </tbody>
            </table>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="booking">
        <xsl:variable name="studentVar"><xsl:value-of select="studentEmail"/></xsl:variable>
        <xsl:variable name="tutorVar"><xsl:value-of select="tutorEmail"/></xsl:variable>
        <xsl:variable name="bookIDVar"><xsl:value-of select="bookingID"/></xsl:variable>
        <xsl:if test="($studentEmail='getAll') or ($studentEmail=$studentVar) or ($tutorEmail=$tutorVar)">
            <form action="booking.jsp" method="GET"><tr>
                <td><xsl:value-of select="bookingID"/></td>
                <td><xsl:value-of select="tutorName"/></td>
                <td><xsl:value-of select="tutorEmail"/></td>
                <td><xsl:value-of select="subject"/></td>
                <td><xsl:value-of select="studentName"/></td>
                <td><xsl:value-of select="studentEmail"/></td>
                <td><xsl:value-of select="status"/></td>
                <td><input type="submit" value="View" name="View"></input></td>
                <td><input type="hidden" value="{$bookIDVar}" id="view" name="view"></input></td>
            </tr></form>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
