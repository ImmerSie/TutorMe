/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

/**
 *
 * @author Mango
 */

import java.io.Serializable;
import javax.xml.bind.annotation.*;

@XmlRootElement(name="tutor")
@XmlAccessorType(XmlAccessType.FIELD)
public class Tutor implements Serializable{
    
    @XmlElement(name = "name")
    private String name;
    @XmlElement(name = "email")
    private String email;
    @XmlElement(name = "password")
    private String password;
    @XmlElement(name = "birthday")
    private String birthday;
    @XmlElement(name = "userType")
    private String userType;
    @XmlElement(name = "subject")
    private String subject;
    @XmlElement(name = "status")
    private String status;

    public Tutor(){}

    public Tutor(String name, String email, String password, String birthday, String userType, String subject) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.birthday = birthday;
        this.userType = userType;
        this.subject = subject;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

  
    
   
    
    
}
