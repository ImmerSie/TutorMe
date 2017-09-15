/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.io.Serializable;
import java.util.ArrayList;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Max
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "bookings")
public class Bookings implements Serializable{
    
    @XmlElement(name="booking")
    private ArrayList<Booking> bookings = new ArrayList<Booking>();
 
    public ArrayList<Booking> getList() {
        return bookings;
    }
    public void addBooking(Booking booking) {
        bookings.add(booking);
    }
}
