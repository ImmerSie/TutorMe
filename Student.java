/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Mango
 */

import java.io.Serializable;
import javax.xml.bind.annotation.*;

@XmlRootElement(name="student")
@XmlAccessorType(XmlAccessType.FIELD)
public class Student implements Serializable{
    
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
    
    public Student(){}
    
    public Student(String name, String email, String password, String birthday, String userType){
    
        this.name=name;
        this.email=email;
        this.password=password;
        this.birthday=birthday;
        this.userType=userType;
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
    
    
    
}
