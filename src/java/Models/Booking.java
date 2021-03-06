/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.io.Serializable;
import javax.xml.bind.annotation.*;


/**
 *
 * @author Max
 */
@XmlRootElement(name="booking")
@XmlAccessorType(XmlAccessType.FIELD)
public class Booking implements Serializable {
    @XmlElement
    private int bookingID;
    @XmlElement
    private String tutorName;
    @XmlElement
    private String tutorEmail;
    @XmlElement
    private String subject;
    @XmlElement
    private String studentName;
    @XmlElement
    private String studentEmail;
    @XmlElement
    private String status;
    
    public Booking(){
        
    }

    public Booking(int bookingID, String tutorName, String tutorEmail, String subject, String studentName, String studentEmail, String status) {
        this.bookingID = bookingID;
        this.tutorName = tutorName;
        this.tutorEmail = tutorEmail;
        this.subject = subject;
        this.studentName = studentName;
        this.studentEmail = studentEmail;
        this.status = status;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }
    
    
    
    public String getTutorName() {
        return tutorName;
    }

    public void setTutorName(String tutorName) {
        this.tutorName = tutorName;
    }

    public String getTutorEmail() {
        return tutorEmail;
    }

    public void setTutorEmail(String tutorEmail) {
        this.tutorEmail = tutorEmail;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
