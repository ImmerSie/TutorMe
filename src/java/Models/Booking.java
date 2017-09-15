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

    public Booking(String tutorName, String tutorEmail, String subject, String studentName, String sudentEmail, String status) {
        this.tutorName = tutorName;
        this.tutorEmail = tutorEmail;
        this.subject = subject;
        this.studentName = studentName;
        this.studentEmail = sudentEmail;
        this.status = status;
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

    public String getSudentEmail() {
        return studentEmail;
    }

    public void setSudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
