<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : viewBooking.xsl
    Created on : 10 October 2017, 7:10 PM
    Author     : Max
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:param name="viewID"/>
    <xsl:param name="isTutor"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/bookings">
        <html>
            <head>
                <title>viewBooking.xsl</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="booking">
        <xsl:variable name="bookIDVar"><xsl:value-of select="bookingID"/></xsl:variable>
        <xsl:variable name="statusVar"><xsl:value-of select="status"/></xsl:variable>
        <xsl:if test="$bookIDVar=$viewID">
            <p>Booking ID: <xsl:value-of select="bookingID"/></p>
            <p>Tutor Name: <xsl:value-of select="tutorName"/></p>
            <p>Tutor Email: <xsl:value-of select="tutorEmail"/></p>
            <p>Subject: <xsl:value-of select="subject"/></p>
            <p>Student Name: <xsl:value-of select="studentName"/></p>
            <p>Student Email: <xsl:value-of select="studentEmail"/></p>
            <p>Status: <xsl:value-of select="status"/></p>
            
            <xsl:if test="$statusVar='active'">
                <form action="booking.jsp" method="POST">
                    <input type="submit" value="Cancel" name="Cancel"/>
                    <input type="hidden" value="{$bookIDVar}" id="bookingID" name="bookingID"/>
                    <input type="hidden" value="cancelled" id="cancelled" name="cancelled"/>
                </form>
                <xsl:if test="$isTutor='true'">
                    <form action="booking.jsp" method="POST">
                        <input type="submit" value="Complete" name="Complete"/>
                        <input type="hidden" value="{$bookIDVar}" id="bookingID" name="bookingID"/>
                        <input type="hidden" value="completed" id="completed" name="completed"/>
                    </form>
                </xsl:if>
            </xsl:if>
            <form action="booking.jsp" method="POST">
                <input type="submit" value="Close" name="Close"/>
            </form>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
