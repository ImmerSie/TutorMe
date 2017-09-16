/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Applications;

import Models.Booking;
import Models.Bookings;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

/**
 *
 * @author Max
 */
public class BookingApplication {
    private String filePath;
    private Bookings bookings;
    
     public BookingApplication() {}

    public BookingApplication(String filePath, Bookings bookings) {
        super();
        this.filePath = filePath;
        this.bookings = bookings;
    }
    
     public void setFilePath(String filePath) throws Exception {

        // Create the unmarshaller
        JAXBContext jc = JAXBContext.newInstance(Bookings.class);
        Unmarshaller u = jc.createUnmarshaller();
        this.filePath = filePath;
        // Now unmarshal the object from the file
        FileInputStream fin = new FileInputStream(filePath);
        bookings = (Bookings) u.unmarshal(fin); 		
        fin.close();
    }
    public void updateXML(Bookings bookings, String filePath) throws Exception {
        this.bookings = bookings;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Bookings.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(bookings, fout);
        fout.close();
    }
    
    // to be used from the welcome.jsp page
    public void saveBookings() throws JAXBException, IOException {
        JAXBContext jc = JAXBContext.newInstance(Bookings.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(bookings, fout);
        fout.close();
    }

    public Bookings getBookings() {
        return bookings;
    }
    
    public Booking getBookingByID(int id){
        for(Booking b : bookings.getList()){
            if(b.getBookingID() == id){
                return b;
            }
        }
        return null;
    }
    
    public Bookings getBookingsByStudents(String student){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStudentName() == student){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    public Bookings getBookingsByStudent(String student){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStudentName().equals(student)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    public Bookings getBookingsByTutor(String tutor){
        Bookings tutorBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getTutorName().equals(tutor)){
                tutorBookings.getList().add(b);
            }
        }
        return tutorBookings;
    }

    public void setBookings(Bookings bookings) {
        this.bookings = bookings;
    }
    
    public int getNewBookingID(){
        Booking b = getBookings().getList().get(getBookings().getList().size() - 1);
        return b.getBookingID() + 1;
    }
}
