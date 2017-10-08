/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Applications;

import Models.Booking;
import Models.Bookings;
import Models.Student;
import Models.Tutor;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    
    public Bookings getBookingsByID(int id){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getBookingID() == id){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
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
            if(b.getStudentEmail().equals(student)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    public Bookings getBookingsByStudentEmail(String email){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStudentEmail().equals(email)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    public Bookings getBookingsBySubject(String subject){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getSubject().equals(subject)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
       public Bookings getBookingsByStatus(String status){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStatus().equals(status)){
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
    
    public Bookings getBookingsByTutorEmail(String email){
        Bookings tutorBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getTutorEmail().equals(email)){
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
    
    public void createBooking(Tutor tutor, Student student){
        int bookingID = getNewBookingID();
        String tutName = tutor.getName();
        String tutEmail = tutor.getEmail();
        String subject = tutor.getSubject();
        String stuName = student.getName();
        String stuEmail = student.getEmail();
        String status = "active";
        Booking booking = new Booking(bookingID, tutName, tutEmail, subject, stuName, stuEmail, status);
        tutor.setStatus("unavailable");
        getBookings().addBooking(booking);
        try {
            saveBookings();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void cancelBooking(int bookingId){
        Booking booking = getBookingByID(bookingId);
        booking.setStatus("canceled");
        try {
            saveBookings();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        }

    }    
    public void completeBooking(int bookingId){
        Booking booking = getBookingByID(bookingId);
        booking.setStatus("completed");
        try {
            saveBookings();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
